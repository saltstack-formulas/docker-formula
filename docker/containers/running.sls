# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

    {%- if 'running' in d.containers and d.containers.running %}
        {%- for c in d.containers.running|unique %}
            {%- if c in d.containers and d.containers[c] %}

docker-containers-{{ c }}-running:
  docker_container.running:
    - name: {{ c if 'name' not in d.containers[c] else d.containers[c]['name'] }}
    {{- format_kwargs(d.containers[c]) }}

            {% endif %}
        {%- endfor %}
    {%- endif %}
