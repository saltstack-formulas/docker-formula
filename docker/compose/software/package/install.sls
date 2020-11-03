# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.pkg.compose.use_upstream in ('package', 'repo') %}
        {%- if grains.os_family in ('RedHat', 'Debian') %}
            {%- set sls_repo_install = tplroot ~ '.software.package.repo.install' %}

include:
  - {{ sls_repo_install }}

        {%- endif %}

{{ formula }}-docker-compose-package-install-deps:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - pkg: {{ formula }}-docker-compose-package-install-pkgs

{{ formula }}-docker-compose-package-install-pkgs:
  pkg.installed:
    - names: {{ d.pkg.compose.commands|unique|json }}
    - runas: {{ d.identity.rootuser }}
    - reload_modules: true
        {%- if grains.os_family in ('RedHat', 'Debian') %}
    - require:
      - pkgrepo: {{ formula }}-software-package-repo-managed
        {%- endif %}

    {%- else %}

{{ formula }}-docker-compose-package-install-other:
  test.show_notification:
    - text: |
        The docker compose package is unavailable/unselected for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
