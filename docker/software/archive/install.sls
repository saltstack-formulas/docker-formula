# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- if grains.kernel|lower == 'linux' and d.pkg.docker.use_upstream == 'archive' and 'archive' in d.pkg.docker %}
    {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}
    {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

docker-software-docker-archive-install:
    {%- if 'deps' in d.pkg and d.pkg.deps %}
        {%- if grains.os|lower in ('redhat', 'centos') %}
            # python-docker package is not available or too old on CentOS, RedHat
            # https://github.com/saltstack/salt/issues/58920
  pip.installed:
    - name: docker
    - reload_modules: {{ d.misc.reload or true }}
    - require:
      - pkg: docker-software-docker-archive-install
        {%- endif %}
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - reload_modules: {{ d.misc.reload or true }}
    - require_in:
      - file: docker-software-docker-archive-install
    {%- endif %}
  file.directory:
    - name: {{ d.pkg.docker.path }}
    - makedirs: True
    - clean: {{ d.misc.clean }}
    - require_in:
      - archive: docker-software-docker-archive-install
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
      - file: docker-software-docker-archive-install

    {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
        {%- for cmd in d.pkg.docker.commands|unique %}

docker-software-docker-archive-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.pkg.docker.path }}/{{ cmd }}
    - force: True
    - onchanges:
      - archive: docker-software-docker-archive-install
    - require:
      - archive: docker-software-docker-archive-install

        {%- endfor %}
    {%- endif %}
    {%- if 'service' in d.pkg.docker and d.pkg.docker.service is mapping %}

docker-software-docker-archive-install-file-directory:
  file.directory:
    - name: {{ d.dir.lib }}
    - makedirs: True
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - mode: '0755'

docker-software-docker-archive-install-managed-service:
  file.managed:
    - name: {{ d.dir.service }}/{{ d.pkg.docker.service.name }}.service
    - source: {{ files_switch(['systemd.ini.jinja'],
                              lookup='docker-software-docker-archive-install-managed-service'
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
        limitnofile: {{ d.pkg.docker.service.limitnofile }}
        workdir: {{ d.dir.lib }}
        env: {{ d.pkg.docker.service.env }}
        stop: ''
        start: {{ d.pkg.docker.path }}/dockerd
  cmd.run:
    - name: systemctl daemon-reload
    - require:
      - archive: docker-software-docker-archive-install

    {%- endif %}
{%- else %}

docker-software-docker-archive-install-other:
  test.show_notification:
    - text: |
        The docker archive is unavailable/unselected for {{ salt['grains.get']('finger', grains.os_family) }}

{%- endif %}
