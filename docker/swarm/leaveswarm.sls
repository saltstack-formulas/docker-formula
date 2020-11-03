# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'leave_swarm' in d.swarm and d.swarm.leave_swarm %}

{{ formula }}-swarm-leave_swarm:
  module.run:
    - name: swarm.leave_swarm
    - force: true

    {%- endif %}
