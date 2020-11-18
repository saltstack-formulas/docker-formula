# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.kernel|lower in ('linux',) %}
        {%- set sls_alternatives_clean = tplroot ~ '.software.alternatives.clean' %}

include:
  - {{ sls_alternatives_clean }}

{{ formula }}-docker-compose-archive-absent:
  file.absent:
    - names:
      - {{ d.dir.tmp }}/docker-compose
      - {{ d.pkg.compose.path }}
        {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
            {%- for cmd in d.pkg.compose.commands|unique %}
      - /usr/local/bin/{{ cmd }}
            {%- endfor %}
        {%- endif %}

    {%- endif %}
