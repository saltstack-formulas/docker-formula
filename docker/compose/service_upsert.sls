# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

include:
  - .create

    {%- if 'applications' in d.compose and d.compose.applications %}
        {%- for service in d.compose.applications|unique %}
            {%- if 'path' in d.compose[service] and d.compose[service]['path'] %}
                {%- if 'service_name' in d.compose[service] and d.compose[service]['service_name'] %}
                    {%- if 'definition' in d.compose[service] and d.compose[service]['definition'] %}

docker-compose-{{ service }}-service_upsert:
  module.run:
    - name: dockercompose.service_upsert
    - path: {{ d.compose[service]['path'] }}
    - service_name: {{ d.compose[service]['service_name'] }}
    - definition: {{ d.compose[service]['definition'] }}

                    {% endif %}
                {% endif %}
            {% endif %}
        {%- endfor %}
    {%- endif %}
