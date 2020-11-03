# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'running' in d.containers and d.containers.running %}
        {%- for c in d.containers.running|unique %}

{{ formula }}-containers-{{ c }}-stopped:
  docker_container.stopped:
    - name: {{ c }}
    - onlyif: docker container inspect {{ c }}

        {%- endfor %}
    {%- endif %}
