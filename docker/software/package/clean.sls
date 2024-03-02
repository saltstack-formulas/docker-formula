# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- if d.pkg.docker.use_upstream in ('package', 'repo') %}
    {%- set enable_repo = grains.os_family in ('RedHat', 'Debian') and d.pkg.docker.get('repo') %}
    {%- if enable_repo %}
        {%- set sls_repo_clean = tplroot ~ '.software.package.repo.clean' %}
        {%- set resource_repo_clean = 'file' if grains.os_family == 'Debian' else 'pkgrepo' %}
include:
  - {{ sls_repo_clean }}
    {%- endif %}

    {%- if grains.kernel|lower in ('linux', 'darwin') %}
docker-software-package-clean-pkg:
  pkg.removed:
    - names:
      - {{ d.pkg.docker.name }}
      - python3-docker
    - reload_modules: {{ d.misc.reload|default(true, true) }}
        {%- if enable_repo %}
    - require:
      - {{ resource_repo_clean }}: docker-software-package-repo-absent
        {%- endif %}

    {%- elif grains.os_family == 'MacOS' %}

docker-software-package-clean-brew:
  cmd.run:
    - name:  /usr/local/bin/brew uninstall docker-machine docker-cli
    - runas: {{ d.identity.rootuser }}
    - onlyif:
      - brew list | grep ^docker-machine$

    {%- elif grains.os_family == 'Windows' %}

docker-software-package-clean-choco:
  chocolatey.uninstalled:
    - name: {{ d.pkg.docker.name }}

    {%- endif %}
{%- else %}

docker-software-package-clean-other:
  test.show_notification:
    - text: |
        The docker package is unavailable/unselected for {{ salt['grains.get']('finger', grains.os_family) }}

{%- endif %}
