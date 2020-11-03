# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'swarm_service_info' in d.swarm and d.swarm.swarm_service_info is mapping %}
        {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-swarm-swarm_service_info:
  module.run:
    - name: swarm.swarm_service_info
    {{- format_kwargs(d.swarm.swarm_service_info) }}

    {%- endif %}
