# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if 'swarm_init' in d.swarm and d.swarm.swarm_init is mapping %}
        {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

docker-swarm-swarm_init:
  module.run:
    - name: swarm.swarm_init
    {{- format_kwargs(d.swarm.swarm_init) }}

    {%- endif %}
