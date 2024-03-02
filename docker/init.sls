# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- if d.wanted is iterable %}

include:
  {{ '- .software' if 'docker' in d.wanted else '' }}
  {{ '- .compose' if 'compose' in d.wanted else '' }}
  # .networks
  # .containers

{%- endif %}
