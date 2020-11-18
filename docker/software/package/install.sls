# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.pkg.docker.use_upstream in ('package', 'repo') %}
        {%- set docker_pkg_version = d.version | default(d.pkg.version, true) %}
        {%- if grains.os_family in ('RedHat', 'Debian') %}
            {%- set sls_repo_install = tplroot ~ '.software.package.repo.install' %}

include:
  - {{ sls_repo_install }}
        {%- endif %}
        {%- if grains.kernel|lower in ('linux', 'darwin') %}
            {%- if 'deps' in d.pkg and d.pkg.deps %}

{{ formula }}-software-package-install-deps:
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - pkg: {{ formula }}-software-package-install-pkg

            {%- endif %}

{{ formula }}-software-package-install-pkg:
  pkg.installed:
    - name: {{ d.pkg.docker.name }}
    - version: {{ docker_pkg_version or d.pkg.version or 'latest' }}
    - runas: {{ d.identity.rootuser }}
    - reload_modules: {{ d.misc.reload|default(true, true) }}
    - refresh: {{ d.misc.refresh|default(true, true) }}
            {%- if grains.os|lower not in ('suse',) %}
    - hold: {{ d.misc.hold|default(false, true) }}
            {%- endif %}
            {%- if grains.os_family in ('RedHat', 'Debian') %}
    - require:
      - pkgrepo: {{ formula }}-software-package-repo-managed
            {%- endif %}

        {%- elif grains.kernel|lower in ('windows',) %}

{{ formula }}-software-package-install-deps:
  chocolatey.installed:
    - name: docker-cli
    - force: True

{{ formula }}-software-package-install-choco:
  chocolatey.installed:
    - name: docker-machine
    - force: True

        {%- endif %}
    {%- else %}

{{ formula }}-software-package-install-other:
  test.show_notification:
    - text: |
        The docker package is unavailable/unselected for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
