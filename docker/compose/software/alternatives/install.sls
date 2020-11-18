# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if d.linux.altpriority|int > 0 and grains.kernel == 'Linux' and grains.os_family not in ('Arch',) %}
        {%- set sls_binary_install = tplroot ~ '.compose.software.binary.install' %}

include:
  - {{ sls_binary_install }}

        {%- for cmd in d.pkg.compose.commands|unique %}
{{ formula }}-docker-compose-alternatives-install-bin-{{ cmd }}:
            {%- if grains.os_family not in ('Suse', 'Arch') %}
  alternatives.install:
    - name: link-docker-compose-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - order: 10
    - path: {{ d.pkg.compose['path'] }}/bin/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
            {%- else %}
  cmd.run:
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-docker-compose-{{ cmd }} {{ d.pkg.compose['path'] }}/bin/{{ cmd }} {{ d.linux.altpriority }} # noqa 204
            {%- endif %}

    - onlyif:
      - test -f {{ d.pkg.compose['path'] }}/bin/{{ cmd }}
    - unless: update-alternatives --list |grep ^link-docker-compose-{{ cmd }} || false
    - require:
      - sls: {{ sls_binary_install }}
    - require_in:
      - alternatives: {{ formula }}-docker-compose-alternatives-set-bin-{{ cmd }}

{{ formula }}-docker-compose-alternatives-set-bin-{{ cmd }}:
  alternatives.set:
    - unless: {{ grains.os_family in ('Suse', 'Arch') }} || false
    - name: link-docker-compose-{{ cmd }}
    - path: {{ d.pkg.compose.path }}/bin/{{ cmd }}
    - onlyif: test -f {{ d.pkg.compose['path'] }}/bin/{{ cmd }}

        {%- endfor %}
    {%- endif %}
