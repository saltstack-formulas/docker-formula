# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.kernel == 'Linux' and d.linux.altpriority|int > 0 and grains.os_family not in ('Arch',) %}
        {%- for cmd in d.pkg.docker.commands|unique %}

{{ formula }}-docker-alternatives-clean-{{ cmd }}:
  alternatives.remove:
    - name: link-docker-docker-{{ cmd }}
    - path: {{ d.pkg.docker.path }}/bin/{{ cmd }}
    - onlyif: update-alternatives --list |grep ^link-docker-docker-{{ cmd }}

        {%- endfor %}
    {%- endif %}
