# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

    {%- if grains.kernel|lower == 'linux' and d.pkg.docker.use_upstream == 'archive' and 'archive' in d.pkg.docker %}
        {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{{ formula }}-software-docker-archive-install:
        {%- if 'deps' in d.pkg and d.pkg.deps %}
            {%- if grains.os|lower == 'centos' %}
                # https://github.com/saltstack/salt/issues/58920
  pip.installed:
    - name: docker
            {%- endif %}
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - reload_modules: {{ d.misc.reload or true }}
    - require_in:
      - file: {{ formula }}-software-docker-archive-install
        {%- endif %}
  file.directory:
    - name: {{ d.pkg.docker.path }}
    - makedirs: True
    - clean: {{ d.misc.clean }}
    - require_in:
      - archive: {{ formula }}-software-docker-archive-install
    - mode: 755
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
        - mode
  archive.extracted:
    - unless: test -x {{ d.pkg.docker.path }}{{ d.div }}docker
    {{- format_kwargs(d.pkg.docker['archive']) }}
    - retry: {{ d.retry_option|json }}
    - enforce_toplevel: false
    - trim_output: true
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
    - require:
      - file: {{ formula }}-software-docker-archive-install

        {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
            {%- for cmd in d.pkg.docker.commands|unique %}

{{ formula }}-software-docker-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.pkg.docker.path }}/{{ cmd }}
    - force: True
    - onchanges:
      - archive: {{ formula }}-software-docker-archive-install
    - require:
      - archive: {{ formula }}-software-docker-archive-install

            {%- endfor %}
        {%- endif %}
        {%- if 'service' in d.pkg.docker and d.pkg.docker.service is mapping %}

{{ formula }}-software-docker-archive-install-file-directory:
  file.directory:
    - name: {{ d.dir.lib }}
    - makedirs: True
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: '0755'

{{ formula }}-software-docker-archive-install-managed-service:
  file.managed:
    - name: {{ d.dir.service }}/{{ d.pkg.docker.service.name }}.service
    - source: {{ files_switch(['systemd.ini.jinja'],
                              lookup=formula ~ '-software-docker-archive-install-managed-service'
                 )
              }}
    - mode: '0644'
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        desc: {{ d.pkg.docker.service.name }} service
        name: {{ d.pkg.docker.service.name }}
        user: {{ d.identity.rootuser }}
        group: {{ d.identity.rootgroup }}
        workdir: {{ d.dir.lib }}
        stop: ''
        start: {{ d.pkg.docker.path }}/{{ d.pkg.docker.service.name }}
  cmd.run:
    - name: systemctl daemon-reload
    - require:
      - archive: {{ formula }}-software-docker-archive-install

        {%- endif %}
    {%- else %}

{{ formula }}-software-docker-archive-install-other:
  test.show_notification:
    - text: |
        The docker archive is unavailable/unselected for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}
