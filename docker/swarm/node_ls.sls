# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'node_ls' in d.swarm and d.swarm.node_ls is mapping %}
        {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-swarm-node_ls:
  module.run:
    - name: swarm.node_ls
    {{- format_kwargs(d.swarm.node_ls) }}

    {%- endif %}
