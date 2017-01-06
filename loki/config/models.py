#!/usr/bin/env python
# -*- coding: utf-8 -*-
import requests

from ..base.models import db, ModelMixin
from loki.settings import PUPPET_CLASS_URL


def puppet_classes():
    return requests.get(PUPPET_CLASS_URL).json()


class NodeConfig(db.Model, ModelMixin):
    __tablename__ = "node_config"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    node_id = db.Column(db.Integer, nullable=False, index=True, unique=True)
    name = db.Column(db.String(50), nullable=False, index=True, unique=True)

    __table_args__ = (
        db.UniqueConstraint('node_id', name='node_id'),)
