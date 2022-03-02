# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if d.pkg.docker.use_upstream in ('package', 'repo') %}
        {%- set enable_repo = grains.os_family in ('RedHat', 'Debian') and d.pkg.docker.get('repo') %}
        {%- set docker_pkg_version = d.version | default(d.pkg.version, true) %}
        {%- if enable_repo %}
            {%- set sls_repo_install = tplroot ~ '.software.package.repo.install' %}
            {%- set resource_repo_managed = 'file' if grains.os_family == 'Debian' else 'pkgrepo' %}
include:
  - {{ sls_repo_install }}
        {%- endif %}

        {%- if grains.kernel|lower in ('linux', 'darwin') %}
            {%- if 'deps' in d.pkg and d.pkg.deps %}

docker-software-package-install-deps:
                {%- if grains.os|lower in ('centos', 'redhat') %}
                    # python-docker package is not available or too old on CentOS, RedHat
                    # https://github.com/saltstack/salt/issues/58920
  pip.installed:
    - name: docker
    - reload_modules: {{ d.misc.reload or true }}
    - require:
      - pkg: docker-software-package-install-deps
                {%- endif %}
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - require_in:
      - pkg: docker-software-package-install-pkg

            {%- endif %}

docker-software-package-install-pkg:
  pkg.installed:
    - name: {{ d.pkg.docker.name }}
    - version: {{ docker_pkg_version or d.pkg.version or 'latest' }}
    - runas: {{ d.identity.rootuser }}
    - reload_modules: {{ d.misc.reload|default(true, true) }}
    - refresh: {{ d.misc.refresh|default(true, true) }}
            {%- if grains.os|lower not in ('suse',) %}
    - hold: {{ d.misc.hold|default(false, true) }}
            {%- endif %}
            {%- if enable_repo %}
    - require:
      - {{ resource_repo_managed }}: docker-software-package-repo-managed
            {%- endif %}

        {%- elif grains.kernel|lower in ('windows',) %}

docker-software-package-install-deps:
  chocolatey.installed:
    - name: docker-cli
    - force: True

docker-software-package-install-choco:
  chocolatey.installed:
    - name: docker-machine
    - force: True

        {%- endif %}
    {%- else %}

docker-software-package-install-other:
  test.show_notification:
    - text: |
        The docker package is unavailable/unselected for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
