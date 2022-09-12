# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if 'applications' in d.compose and d.compose.applications %}
        {%- for service in d.compose.applications|unique %}
            {%- if 'path' in d.compose[service] and d.compose[service]['path'] %}
                {%- if 'compose' in d.compose[service] and d.compose[service]['compose'] %}

                    {%- set compose = salt['slsutil.serialize'](
                        'yaml',
                        default_flow_style=False,
                        obj=d.compose[service]['compose'])
                    %}

docker-compose-{{ service }}-create:
  module.run:
    - name: dockercompose.create
    - path: {{ d.compose[service]['path'] }}
    - docker_compose: {{ salt['slsutil.serialize']('yaml', compose) }}

                {%- endif %}
            {% endif %}
        {%- endfor %}
    {%- endif %}
