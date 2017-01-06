#-*- coding: utf-8 -*-

import re
from collections import defaultdict
from sqlalchemy.exc import IntegrityError
from decimal import Decimal as D  # NOQA
from torext import params

from .. import errors
from ..base.handlers import APIHandler
from .models import NodeConfig, puppet_classes
from ..privilege import require_node_privileges
from .privileges import ConfigRelativesPrivilege



class ClassHandler(APIHandler):
    def get(self):
        data = puppet_classes()
        self.write_data(data)


class ConfigsHandler(APIHandler):
    args = ["id", "node_id", "name"]

    def get(self):
        select_oj = NodeConfig.query.all()
        data = [o.to_dict(*self.args) for o in select_oj]
        self.write_json(data)


class ConfigRelativesHandler(APIHandler):
    args = ["id", "node_id", "name"]

    def get(self, node_id):
        record = NodeConfig.query.filter_by(node_id=node_id).first()
        if record:
            data = record.to_dict(*self.args)
            self.write_data([data])
        else:
            self.write_data([])


    @require_node_privileges(ConfigRelativesPrivilege.config_relatives, lambda c: int(c.args[0]))
    @params.simple_params(datatype="json")
    def put(self, node_id):
        name = self.params['name']

        if name not in [i["name"] for i in puppet_classes()]:
            raise errors.ParamsInvalidError('config %s not exists' % name)

        record = NodeConfig(
            node_id=node_id,
            name=name
        )
        try:
            ret = record.save()
            if ret:
                data = {
                    "status": True, 
                    "message": "bind {0} to {1} succeed".format(name, node_id)
                }
                self.write_json(data)
            else:
                self.api_error(400, "create fail")
        except IntegrityError:
            self.api_error(400, "duplicated record")

    @require_node_privileges(ConfigRelativesPrivilege.config_relatives, lambda c: int(c.args[0]))
    @params.simple_params(datatype="json")
    def delete(self, node_id):
        record = NodeConfig.query.filter_by(node_id=node_id).first()
        if not record:
            raise errors.DoesNotExist('config %s not found' % node_id)

        record.delete()
        data = {
            "status": True, 
            "message": "unbind {0} succeed".format(node_id)
        }
        self.write_json(data)


handlers = [
    # puppet class.
    ('/classes', ClassHandler),

    ('/(\d+)', ConfigRelativesHandler),
    ('/?', ConfigsHandler),
]
