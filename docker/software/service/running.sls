# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'service' in d.pkg.docker and d.pkg.docker.service and grains.os != 'Windows' %}
        {%- set sls_config_file = tplroot ~ '.software.config.file' %}
        {%- set sls_archive = tplroot ~ '.software.archive.install' %}
        {%- set sls_desktop = tplroot ~ '.software.desktop.install' %}
        {%- set sls_package = tplroot ~ '.software.package.install' %}

include:
  - {{ sls_archive if d.pkg.docker.use_upstream == 'archive' else sls_desktop if d.pkg.docker.use_upstream == 'desktop' else sls_package }}
  - {{ sls_config_file }}

        {%- if grains.kernel|lower == 'linux' %}

{{ formula }}-software-service-running-unmasked:
  service.unmasked:
    - name: {{ d.pkg.docker.service.name }}
    - onlyif: systemctl list-unit-files | grep {{ d.pkg.docker.service.name }} >/dev/null 2>&1
    - require_in:
      - service: {{ formula }}-software-service-running-docker
            {%- if 'config' in d.pkg.docker and d.pkg.docker.config %}
    - require:
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
        {%- if 'config' in d.pkg.docker and d.pkg.docker.config %}
    - require:
      - sls: {{ sls_config_file }}
        {%- endif %}
    - enable: True
        {%- if grains.kernel|lower == 'linux' %}
    - onlyif: systemctl list-unit-files | grep {{ d.pkg.docker.service.name }} >/dev/null 2>&1

{{ formula }}-software-service-running-docker-fail-notify:
  test.show_notification:
    - text: |
        * Rebooting your host is recommended!
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
