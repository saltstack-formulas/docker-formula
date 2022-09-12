# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

include:
  - .create

    {%- if 'applications' in d.compose and d.compose.applications %}
        {%- for service in d.compose.applications|unique %}
            {%- if 'path' in d.compose[service] and d.compose[service]['path'] %}

docker-compose-{{ service }}-stop:
  module.run:
    - name: dockercompose.stop
    - path: {{ d.compose[service]['path'] }}
                {%- if 'services_names' in d.compose[service] and d.compose[service]['service_names'] is iterable %}
    - service_names: {{ d.compose[service]['service_names'] }}
                {%- endif %}

            {% endif %}
        {%- endfor %}
    {%- endif %}
