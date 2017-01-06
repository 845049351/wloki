# coding=utf-8
from ..base.privileges import PrivilegeBase, PrivilegeItem, PrivilegeGroup


class ConfigRelativesPrivilege(PrivilegeBase):
    __type__ = PrivilegeGroup.normal
    __privileges__ = (
        PrivilegeItem('admin', u'管理 config_relatives 权限的分配'),
        PrivilegeItem('config_relatives', u'管理配置关联 (CRUD)'),
    )
    __privilege_name__ = 'config_relatives'
    __privilege_alias__ = '配置关联'
