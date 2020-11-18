# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.kernel == 'Linux' and d.linux.altpriority|int > 0 and grains.os_family not in ('Arch',) %}
        {%- set sls_archive_install = tplroot ~ '.docker.archive.install' %}

include:
  - {{ sls_archive_install }}

        {%- for cmd in d.pkg.docker.commands|unique %}
{{ formula }}-docker-alternatives-install-bin-{{ cmd }}:
            {%- if grains.os_family not in ('Suse', 'Arch') %}
  alternatives.install:
    - name: link-docker-docker-{{ cmd }}
    - link: /usr/local/bin/{{ cmd }}
    - order: 10
    - path: {{ d.pkg.docker['path'] }}/{{ cmd }}
    - priority: {{ d.linux.altpriority }}
            {%- else %}
  cmd.run:
    - name: update-alternatives --install /usr/local/bin/{{ cmd }} link-docker-docker-{{ cmd }} {{ d.pkg.docker['path'] }}/{{ cmd }} {{ d.linux.altpriority }} # noqa 204
            {%- endif %}

    - onlyif:
      - test -f {{ d.pkg.docker['path'] }}/{{ cmd }}
    - unless: update-alternatives --list |grep ^link-docker-docker-{{ cmd }} || false
    - require:
      - sls: {{ sls_archive_install }}
    - require_in:
      - alternatives: {{ formula }}-docker-alternatives-set-bin-{{ cmd }}

{{ formula }}-docker-alternatives-set-bin-{{ cmd }}:
  alternatives.set:
    - unless: {{ grains.os_family in ('Suse', 'Arch') }} || false
    - name: link-docker-docker-{{ cmd }}
    - path: {{ d.pkg.docker.path }}/{{ cmd }}
    - onlyif: test -f {{ d.pkg.docker['path'] }}/{{ cmd }}

        {%- endfor %}
    {%- endif %}
