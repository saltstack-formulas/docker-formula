# -*- coding: utf-8 -*-
# vim: ft=sls
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import docker with context %}
{%- set sls_package_install = tplroot ~ '.install' %}
{%- set sls_macapp_install = tplroot ~ '.macosapp' %}

include:
  - {{ sls_package_install if not docker.pkg.use_upstream_app else sls_macapp_install }}
