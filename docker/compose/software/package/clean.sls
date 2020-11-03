# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.pkg.compose.use_upstream in ('package', 'repo') %}
        {%- if grains.os_family|lower in ('redhat', 'debian') %}
            {%- set sls_repo_clean = tplroot ~ '.software.package.repo.clean' %}
include:
  - {{ sls_repo_clean }}
        {%- endif %}

{{ formula }}-docker-compose-package-clean-pkgs:
  pkg.removed:
    - name: {{ d.pkg.compose.name }}
    - reload_modules: true
        {%- if grains.os_family|lower in ('redhat', 'debian') %}
    - require:
      - pkgrepo: {{ formula }}-software-package-repo-absent
        {%- endif %}

    {%- endif %}
