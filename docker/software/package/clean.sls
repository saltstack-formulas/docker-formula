# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.pkg.docker.use_upstream in ('package', 'repo') %}
        {%- if grains.kernel|lower in ('linux',) %}
            {%- if d.pkg.docker.use_upstream == 'repo' %}
include:
  - .package.repo.clean
            {%- endif %}

{{ formula }}-software-package-clean-pkg:
  pkg.removed:
    - name: kubectl
    - reload_modules: true
            {%- if d.pkg.docker.use_upstream == 'repo' %}
    - require:
      - pkgrepo: {{ formula }}-package-repo-absent
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
