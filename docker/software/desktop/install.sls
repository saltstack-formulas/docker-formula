# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- if grains.os|lower in ('darwin', 'windows') %}
    {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}
    {%- if d.pkg.docker.use_upstream == 'desktop' and 'desktop' in d.pkg.docker %}

        {%- if grains.os == 'MacOS' %}
docker-software-desktop-download-tmpdir:
  file.directory:
    - name: {{ d.dir.tmp }}
    - makedirs: true
    - require_in:
      - pkg: docker-macos-app-install-cmd-run
        {%- endif %}

docker-software-desktop-download:
  file.managed:
    - name: {{ d.dir.tmp }}{{ d.div }}Docker-Desktop{{ d.pkg.docker.suffix }}
    - source: {{ d.pkg.docker.desktop.source }}
    - source_hash: {{ d.pkg.docker.desktop.source_hash }}
    - unless: test -f {{ d.dir.tmp }}{{ d.div }}Docker-Desktop{{ d.pkg.docker.suffix }}
    - makedirs: True
    - retry: {{ d.retry_option|json }}

docker-software-desktop-install:

        {%- if grains.os|lower == 'windows' %}
  pip.installed:
    - name: docker
    - runas: {{ d.identity.rootuser }}
  cmd.run:
    - name: {{ d.dir.tmp }}{{ d.div }}Docker-Desktop{{ d.pkg.docker.suffix }} || true
    - require:
      - file: docker-software-desktop-download

        {%- elif grains.os|lower == 'macos' %}
  macpackage.installed:
    - name: {{ d.dir.tmp }}/Docker-Desktop{{ d.pkg.docker.suffix }}
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
    - onchanges:
      - file: docker-software-desktop-download
  file.append:
    - name: /Users/{{ d.identity.rootuser }}/.bash_profile
    - text: 'export PATH=$PATH:/Applications/Docker.app/Contents/Versions/latest/bin'
    - require:
      - macpackage: docker-software-desktop-install

        {%- endif %}
    {%- endif %}
{%- else %}

docker-software-desktop-install-other:
  test.show_notification:
    - text: |
        The docker desktop is unavailable/unselected for {{ salt['grains.get']('finger', grains.os_family) }}

{%- endif %}
