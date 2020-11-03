# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'remove_service' in d.swarm and d.swarm.remove_service is mapping %}
        {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-swarm-remove_service:
  module.run:
    - name: swarm.remove_service
    {{- format_kwargs(d.swarm.remove_service) }}

    {%- endif %}
