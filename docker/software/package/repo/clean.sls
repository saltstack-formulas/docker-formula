# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-software-package-repo-absent:
  pkgrepo.absent:
    - name: {{ d.pkg.docker.repo.name }}
    - onlyif:
      - {{ d.pkg.docker.repo }}
