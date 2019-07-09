# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import docker with context %}
{%- set sls_package_install = tplroot ~ '.install' %}
{%- set sls_macapp_install = tplroot ~ '.macosapp.install' %}

include:
  - {{ sls_macapp_install if docker.pkg.use_upstream_app else sls_package_install }}
