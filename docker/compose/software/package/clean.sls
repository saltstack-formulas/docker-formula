# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- if d.pkg.compose.use_upstream in ('package', 'repo') %}
    {%- if grains.os_family|lower in ('redhat', 'debian') %}
        {%- set sls_repo_clean = tplroot ~ '.software.package.repo.clean' %}
        {%- set resource_repo_clean = 'file' if grains.os_family == 'Debian' else 'pkgrepo' %}

include:
  - {{ sls_repo_clean }}
    {%- endif %}

docker-compose-package-clean-pkgs:
  pkg.removed:
    - name: {{ d.pkg.compose.name }}
    - reload_modules: true
    {%- if grains.os_family|lower in ('redhat', 'debian') %}
    - require:
      - {{ resource_repo_clean }}: docker-software-package-repo-absent
    {%- endif %}

{%- endif %}
