# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'joinswarm' in d.swarm and d.swarm.joinswarm is mapping %}
        {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-swarm-joinswarm:
  module.run:
    - name: swarm.joinswarm
    {{- format_kwargs(d.swarm.joinswarm) }}

    {%- endif %}
