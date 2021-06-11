# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'service' in d.pkg.docker and d.pkg.docker.service and grains.os != 'Windows' %}
        {%- set sls_config_daemon = tplroot ~ '.software.config.daemon' %}
        {%- set sls_config_file = tplroot ~ '.software.config.file' %}
        {%- set sls_archive = tplroot ~ '.software.archive.install' %}
        {%- set sls_desktop = tplroot ~ '.software.desktop.install' %}
        {%- set sls_package = tplroot ~ '.software.package.install' %}

include:
  - {{ sls_archive if d.pkg.docker.use_upstream == 'archive' else sls_desktop if d.pkg.docker.use_upstream == 'desktop' else sls_package }}
  - {{ sls_config_file }}
  - {{ sls_config_daemon }}

        {%- if grains.kernel|lower == 'linux' %}

{{ formula }}-software-service-running-unmasked:
  service.unmasked:
    - name: {{ d.pkg.docker.service.name }}
    - onlyif: systemctl list-unit-files | grep {{ d.pkg.docker.service.name }} >/dev/null 2>&1
    - require_in:
      - service: {{ formula }}-software-service-running-docker
    - require:
      - sls: {{ sls_config_daemon }}
            {%- if 'config' in d.pkg.docker and d.pkg.docker.config %}
      - sls: {{ sls_config_file }}
            {%- endif %}
            {%- if d.misc.firewall %}
  pkg.installed:
    - name: firewalld
    - reload_modules: true
            {%- endif %}

        {%- endif %}

{{ formula }}-software-service-running-docker:
  service.running:
    - name: {{ d.pkg.docker.service.name }}
    - require:
      - sls: {{ sls_config_daemon }}
        {%- if 'config' in d.pkg.docker and d.pkg.docker.config %}
      - sls: {{ sls_config_file }}
        {%- endif %}
    - enable: True
    - watch:
      - file: {{ formula }}-software-daemon-file-managed-daemon_file

        {%- if grains.kernel|lower == 'linux' %}

{{ formula }}-software-service-running-docker-fail-notify:
  test.fail_without_changes:
    - comment: |
        Formula is trying to start '{{ d.pkg.docker.service.name }}' service
        but failed, is it a correct name for Docker service in your OS?

        In certain circumstances the docker service will not start.
        Your kernel is missing some modules, or not in ideal state.
        See https://github.com/moby/moby/blob/master/contrib/check-config.sh
        * Rebooting your host is recommended!
    - onfail:
      - service: {{ formula }}-software-service-running-docker
  service.enabled:
    - onlyif: {{ grains.kernel|lower == 'linux' }}
    - name: {{ d.pkg.docker.service.name }}
    - onfail:
      - service: {{ formula }}-software-service-running-docker

            {%- if d.misc.firewall and d.pkg.docker.firewall.ports %}

{{ formula }}-software-service-running-docker:
  service.running:
     - name: firewalld
  firewalld.present:
    - name: public
    - ports: {{ d.pkg.docker.firewall.ports|json }}
    - require:
      - service: {{ formula }}-software-service-running-docker

            {%- endif %}
        {%- endif %}
    {%- endif %}
