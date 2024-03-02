# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- if 'service_create' in d.swarm and d.swarm.service_create is mapping %}
    {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

docker-swarm-service_create:
  module.run:
    - name: swarm.service_create
    {{- format_kwargs(d.swarm.service_create) }}

{%- endif %}
