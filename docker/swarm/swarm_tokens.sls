# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if 'swarm_tokens' in d.swarm and d.swarm.swarm_tokens %}

docker-swarm-swarm_tokens:
  module.run:
    - name: swarm.swarm_tokens

    {%- endif %}
