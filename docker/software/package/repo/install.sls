# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'repo' in d.pkg.docker and d.pkg.docker.repo %}
        {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{{ formula }}-software-package-repo-managed:
  pkgrepo.managed:
    {{- format_kwargs(d.pkg.docker.repo) }}
    - humanname: {{ grains["os"] }} {{ grains["oscodename"]|capitalize }} Docker Package Repository
    - refesh: {{ d.misc.refresh }}
    - onlyif:
      - {{ d.pkg.docker.repo }}

    {%- endif %}
