# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- set sls_archive_clean = tplroot ~ '.software.archive.clean' %}
{%- set sls_package_clean = tplroot ~ '.software.package.clean' %}

include:
  - {{ sls_archive_clean if d.pkg.docker.use_upstream == 'archive' else sls_package_clean }}

docker-software-config-clean:
  file.absent:
    - names:
      - {{ d.pkg.docker.environ_file }}
      - {{ d.pkg.docker.daemon_config_file }}
    - require:
      - sls: {{ sls_archive_clean if d.pkg.docker.use_upstream == 'archive' else sls_package_clean }}
