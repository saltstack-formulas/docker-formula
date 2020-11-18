# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'update_node' in d.swarm and d.swarm.update_node is mapping %}
        {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-swarm-update_node:
  module.run:
    - name: swarm.update_node
    {{- format_kwargs(d.swarm.update_node) }}

    {%- endif %}
