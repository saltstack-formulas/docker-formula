# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if grains.kernel == 'Linux' and d.linux.altpriority|int > 0 and grains.os_family not in ('Arch',) %}
        {%- for cmd in d.pkg.docker.commands|unique %}

docker-alternatives-clean-{{ cmd }}:
  alternatives.remove:
    - name: link-docker-{{ cmd }}
    - path: {{ d.pkg.docker.path }}/bin/{{ cmd }}
    - onlyif: update-alternatives --list |grep ^link-docker-{{ cmd }}

        {%- endfor %}
    {%- endif %}
