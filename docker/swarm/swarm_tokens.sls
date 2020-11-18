# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'swarm_tokens' in d.swarm and d.swarm.swarm_tokens %}

{{ formula }}-swarm-swarm_tokens:
  module.run:
    - name: swarm.swarm_tokens

    {%- endif %}
