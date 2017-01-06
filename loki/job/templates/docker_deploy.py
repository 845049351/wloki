#!/usr/bin/env python
# -*- coding: utf-8 -*-
import re
import copy
from os import path
from loki.job.contexts import Context
from loki.job.base import JobTemplate
from loki.job.arguments import TemplateArgument,DeployArgument
from loki.job.templates.template_mixin import TemplateMixin, make_items, make_items_by_dict
from loki.utils import asyncrequest
from loki.errors import FatalError



class DockerDeploy(JobTemplate, TemplateMixin):
    __templatename__ = "docker_deploy"

    # name = TemplateArgument(label=u"服务名", type="text")
    name = TemplateArgument(label=u"name", type="select")
    hlg_replic = TemplateArgument(label=u"HLG 实例数量", type="number", value=1, required=False)
    db_replic = TemplateArgument(label=u"DB 实例数量", type="number", value=1, required=False)
    inner_port = TemplateArgument(label=u"内部端口", type="text", required=False)
    desire_stat = TemplateArgument(label=u"期望状态", type="text", value="running")
    reserve_cpu = TemplateArgument(label=u"CPU 核数", type="number", value=1)
    reserve_mem = TemplateArgument(label=u"内存", type="text", value="1G")
    branch = DeployArgument(label=u"tag名称", type="select")
    opt = TemplateArgument(label=u"附加选项,支持 swarm 所有的选项", type="text", value="", required=False)


    __order__ = [
        "type",
        "name",
        # "image",
        "hlg_replic",
        "db_replic",
        "inner_port",
        "reserve_cpu",
        "reserve_mem",
        "desire_stat",
        "branch",
        "opt",
        "hlg_select",
        "db_select"
    ]

    @JobTemplate.template_form_hook("name")
    def change_template_package_name(self, value):
        # names = ["hub.internal.DOMAIN.com/apps/mms-webapp-read"]
        # value['items'] = make_items(names)
        try:
            raw = asyncrequest("GET",
                "http://docker.internal.DOMAIN.com/image/services",
                timeout=2)
            images = raw.json()
        except Exception as e:
            raise FatalError(
                "get image error")
        value['items'] = make_items(images)
        return value
    
    @JobTemplate.contexts_hook((Context.deploy_form, Context.dashboard_form),
                               "name")
    def change_deploy_package_name(self, value):
        value.pop('items', None)
        value['type'] = "text"
        return value


    @JobTemplate.deploy_form_hook("branch")
    def change_deploy_branch(self, value):
        try:
            img = asyncrequest("GET",
            "http://docker.internal.DOMAIN.com/image/services/" + str(self.name),
            timeout=2)
        except Exception as e:
            raise FatalError(
                "get branch error")
        branches = [{"label":item["branch"], "value":item["runImage"]} for item in img.json()]
        value['items'] = branches
        return value

    def send_deploy_request(self, node_id, confs=None, shelx=False):
        # img = asyncrequest("GET",
        #     "http://docker.internal.DOMAIN.com/image/services/" + str(self.image),
        #     timeout=2)
        # imgs = img.json()
        arguments = {}
        # self.limit_memory = str(int(1.5*int(re.sub("[^0123456789\.]","",self.reserve_mem)))) + re.sub("[^A-Za-z\.]","",self.reserve_mem)
        arguments['name'] = self.name + '_' + str(node_id)
        arguments['image'] = self.branch
        arguments['reserve_cpu'] = self.reserve_cpu
        arguments['reserve_memory'] = self.reserve_mem
        if self.inner_port:
            arguments['inner_port'] = self.inner_port
        if self.desire_stat:
            arguments['desire_stat'] = self.desire_stat
        if self.opt:
            arguments['opt'] = self.opt
        # if hlg_select
        confs = {
            "hlg_replic": self.hlg_replic,
            "db_replic": self.db_replic,
            "arguments": arguments,
        }
        super(DockerDeploy, self).send_docker_deploy_request(
            confs
            )
