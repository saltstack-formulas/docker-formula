# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{%- if 'running' in d.containers and d.containers.running %}
    {%- set sls_stopped = tplroot ~ '.containers.stopped' %}

include:
  - {{ sls_stopped }}


docker-containers-absent:
  docker_container.absent:
    - names: {{ d.containers.running|unique|json }}
    - require:
      - sls: {{ sls_stopped }}

{%- endif %}
