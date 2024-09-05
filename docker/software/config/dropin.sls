# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if 'environ' in d.pkg.docker and d.pkg.docker.environ and grains.os != 'Windows' %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
        {%- set sls_environ = tplroot ~ '.software.config.environ' %}

include:
  - {{ sls_environ }}

# Use a systemd dropin override to make use of the environ file
docker-software-config-dropin-file:
  file.managed:
    - name: {{ d.pkg.docker.dropin_file }}
    - makedirs: True
    - mode: '0755'
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - require:
      - sls: {{ sls_environ }}

  ini.options_present:
    - name: {{ d.pkg.docker.dropin_file }}
    - sections:
        Service:
          EnvironmentFile: {{ d.pkg.docker.environ_file }}
    - require:
      - file: {{ d.pkg.docker.dropin_file }}

    {%- endif %}
