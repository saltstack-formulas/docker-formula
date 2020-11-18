# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'applications' in d.compose and d.compose.applications %}
        {%- for service in d.compose.applications|unique %}
            {%- if 'path' in d.compose[service] and d.compose[service]['path'] %}

{{ formula }}-compose-{{ service }}-ps:
  module.run:
    - name: dockercompose.ps
    - path: {{ d.compose[service]['path'] }}

            {% endif %}
        {%- endfor %}
    {%- endif %}
