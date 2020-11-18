# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'service_create' in d.swarm and d.swarm.service_create is mapping %}
        {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-swarm-service_create:
  module.run:
    - name: swarm.service_create
    {{- format_kwargs(d.swarm.service_create) }}

    {%- endif %}
