# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'service' in d.pkg.docker and d.pkg.docker.service and grains.os != 'Windows' %}

{{ formula }}-software-service-clean-docker:
  service.dead:
    - name: {{ d.pkg.docker.service.name }}
    - enable: False
        {%- if grains.kernel|lower == 'linux' %}
    - onlyif: systemctl list-units | grep {{ d.pkg.docker.service.name }} >/dev/null 2>&1
  file.absent:
    - name: {{ d.dir.service }}{{ d.div }}docker.service
    - require:
      - service: {{ formula }}-software-service-clean-docker
  cmd.run:
    - name: systemctl daemon-reload
    - require:
      - file: {{ formula }}-software-service-clean-docker
        {%- endif %}

    {%- endif %}
