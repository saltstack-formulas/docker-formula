# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import docker with context %}

    {%- if grains.os == 'MacOS' %}

docker-macos-app-install-file-directory:
  file.directory:
    - name: /tmp/salt-docker-formula
    - makedirs: True
    - require_in:
      - pkg: docker-macos-app-install-cmd-run
      - cmd: docker-macos-app-install-cmd-run

docker-macos-app-install-cmd-run:
  pkg.installed:
    - name: curl
  cmd.run:
    - name: curl -Lo /tmp/salt-docker-formula/{{ docker.pkg.app.name }} {{ docker.pkg.app.source }}
    - unless: test -f /tmp/salt-docker-formula/{{ docker.pkg.app.name }}
    - retry:
        attempts: 3
        interval: 60
        until: True
        splay: 10

        {%- if docker.pkg.app.source_hash %}

docker-macos-app-install-app-hash-module-run:
   module.run:
     - name: file.check_hash
     - path: /tmp/salt-docker-formula/{{ docker.pkg.app.name }}
     - file_hash: {{ docker.pkg.app.source_hash }}
     - require:
       - cmd: docker-macos-app-install-cmd-run
     - require_in:
       - macpackage: docker-macos-app-install-macpackage-installed

        {%- endif %}

docker-macos-app-install-macpackage-installed:
  macpackage.installed:
    - name: /tmp/salt-docker-formula/{{ docker.pkg.app.name }}
    - store: True
    - dmg: True
    - app: True
    - force: True
    - allow_untrusted: True
    - onchanges:
      - cmd: docker-macos-app-install-cmd-run
  file.append:
    - name: /Users/{{ docker.rootuser }}/.bash_profile
    - text: 'export PATH=$PATH:/Applications/Docker.app/Contents/Versions/latest/bin'
    - require:
      - macpackage: docker-macos-app-install-macpackage-installed

    {%- endif %}
