# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'networks' in d and d.networks %}
        {%- set sls_archive = tplroot ~ '.software.archive.install' %}
        {%- set sls_desktop = tplroot ~ '.software.desktop.install' %}
        {%- set sls_package = tplroot ~ '.software.package.install' %}

include:
  - {{ sls_archive if d.pkg.docker.use_upstream == 'archive' else sls_desktop if d.pkg.docker.use_upstream == 'desktop' else sls_package }}

        {%- for name in docker.networks %}

{{ formula }}-network-{{ name }}-absent:
  docker_network.absent:
    - name: {{ name }}

        {%- endfor %}
