# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'applications' in d.compose and d.compose.applications %}
        {%- for service in d.compose.applications|unique %}
            {%- if 'path' in d.compose[service] and d.compose[service]['path'] %}
                {%- if 'service_name' in d.compose[service] and d.compose[service]['service_name'] %}
                    {%- if 'tag' in d.compose[service] and d.compose[service]['tag'] %}

{{ formula }}-compose-{{ service }}-service_set_tag-{{ d.compose[service]['tag'] }}:
  module.run:
    - name: dockercompose.service_set_tag
    - path: {{ d.compose[service]['path'] }}
    - service_name: {{ d.compose[service]['service_name'] }}
    - tag: {{ d.compose[service]['tag'] }}

                    {% endif %}
                {% endif %}
            {% endif %}
        {%- endfor %}
    {%- endif %}
