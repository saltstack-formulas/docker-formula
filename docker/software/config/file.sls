# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if 'config' in d.pkg.docker and d.pkg.docker.config %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
        {%- set sls_archive = tplroot ~ '.software.archive.install' %}
        {%- set sls_desktop = tplroot ~ '.software.desktop.install' %}
        {%- set sls_package = tplroot ~ '.software.package.install' %}

include:
  - {{ sls_archive if d.pkg.docker.use_upstream == 'archive' else sls_desktop if d.pkg.docker.use_upstream == 'desktop' else sls_package }}

{{ formula }}-software-config-file-managed-config_file:
  file.managed:
    - name: {{ d.pkg.docker.config_file }}
    - source: {{ files_switch(['config.sh.jinja'],
                              lookup=formula ~ '-software-config-file-managed-config_file'
                 )
              }}
    - makedirs: True
              {%- if grains.os != 'Windows' %}
    - mode: '0640'
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
              {%- endif %}
    - template: jinja
    - context:
      config: {{ d.pkg.docker.config|json }}
    - require:
      - sls: {{ sls_archive if d.pkg.docker.use_upstream == 'archive' else sls_desktop if d.pkg.docker.use_upstream == 'desktop' else sls_package }}

    {%- endif %}
