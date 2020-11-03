# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
        {%- for cmd in d.pkg.compose.commands|unique %}

{{ formula }}-docker-compose-alternatives-clean-{{ cmd }}:
  alternatives.remove:
    - name: link-docker-docker-compose-{{ cmd }}
    - path: {{ d.pkg.compose.path }}/bin/{{ cmd }}
    - onlyif: update-alternatives --list |grep ^link-docker-docker-compose-{{ cmd }}

        {%- endfor %}
    {%- endif %}
