# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'repo' in d.pkg.docker and d.pkg.docker.repo %}

{{ formula }}-software-package-repo-absent:
  pkgrepo.absent:
    - name: {{ d.pkg.docker.repo.name }}

    {%- endif %}
