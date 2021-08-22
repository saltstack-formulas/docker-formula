# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.pkg.docker.use_upstream in ('package', 'repo') %}
        {%- set enable_repo = grains.os_family in ('RedHat', 'Debian') and d.pkg.docker.get('repo') %}
        {%- if enable_repo %}
            {%- set sls_repo_clean = tplroot ~ '.software.package.repo.clean' %}
include:
  - {{ sls_repo_clean }}
        {%- endif %}

        {%- if grains.kernel|lower in ('linux', 'darwin') %}
{{ formula }}-software-package-clean-pkg:
  pkg.removed:
    - name: {{ d.pkg.docker.name }}
    - reload_modules: {{ d.misc.reload|default(true, true) }}
            {%- if enable_repo %}
    - require:
      - pkgrepo: {{ formula }}-software-package-repo-absent
            {%- endif %}

        {%- elif grains.os_family == 'MacOS' %}

{{ formula }}-software-package-clean-brew:
  cmd.run:
    - name:  /usr/local/bin/brew uninstall docker-machine docker-cli
    - runas: {{ d.identity.rootuser }}
    - onlyif:
      - brew list | grep ^docker-machine$

        {%- elif grains.os_family == 'Windows' %}

{{ formula }}-software-package-clean-choco:
  chocolatey.uninstalled:
    - name: {{ d.pkg.docker.name }}

        {%- endif %}
    {%- else %}

{{ formula }}-software-package-clean-other:
  test.show_notification:
    - text: |
        The docker package is unavailable/unselected for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
