# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- if 'running' in d.containers and d.containers.running %}
    {%- for c in d.containers.running|unique %}

docker-containers-{{ c }}-stopped:
  docker_container.stopped:
    - name: {{ c }}
    - onlyif: docker container inspect {{ c }}

    {%- endfor %}
{%- endif %}
