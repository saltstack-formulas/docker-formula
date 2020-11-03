# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

{{ formula }}-docker-desktop-absent:
  file.absent:
    - names:
      - {{ d.pkg.docker.path }}
      - {{ d.dir.tmp }}{{ d.div }}Docker-Desktop{{ d.pkg.docker.suffix }}
      - {{ d.div }}Applications{{ d.div }}Docker.app
