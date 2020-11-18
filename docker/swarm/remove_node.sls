# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'remove_node' in d.swarm and d.swarm.remove_node is mapping %}
        {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-swarm-remove_node:
  module.run:
    - name: swarm.remove_node
    {{- format_kwargs(d.swarm.remove_node) }}

    {%- endif %}
