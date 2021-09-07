# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if 'leave_swarm' in d.swarm and d.swarm.leave_swarm %}

docker-swarm-leave_swarm:
  module.run:
    - name: swarm.leave_swarm
    - force: true

    {%- endif %}
