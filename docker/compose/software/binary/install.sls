# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if grains.kernel|lower in ('linux',) %}
        {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}
        {%- if d.pkg.compose.use_upstream == 'binary' and 'binary' in d.pkg.compose %}

docker-compose-software-binary-install:
        {%- if 'deps' in d.pkg and d.pkg.deps %}
            {%- if grains.os|lower in ('centos', 'redhat') %}
                # python-docker package is not available or too old on CentOS, RedHat
                # https://github.com/saltstack/salt/issues/58920
  pip.installed:
    - name: docker
    - reload_modules: {{ d.misc.reload or true }}
    - require:
      - pkg: docker-compose-software-binary-install
            {%- endif %}
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - reload_modules: {{ d.misc.reload or true }}
    - require_in:
      - file: docker-compose-software-binary-install
        {%- endif %}
  file.managed:
    - unless: test -x {{ d.pkg.compose.path }}/docker-compose
    - name: {{ d.pkg.compose.path }}/docker-compose
    - source: {{ d.pkg.compose.binary.source }}
    - clean: {{ d.misc.clean }}
        {%- if 'source_hash' in d.pkg.compose.binary and d.pkg.compose.binary.source_hash %}
    - source_hash: {{ d.pkg.compose.binary.source_hash }}
        {%- else %}
    - skip_verify: True
        {%- endif %}
    - makedirs: True
    - retry: {{ d.retry_option|json }}
    - mode: '0755'
    - user: {{ d.identity.rootuser }}
    - group: {{ d.identity.rootgroup }}
    - recurse:
        - user
        - group
        - mode

            {%- if d.linux.altpriority|int == 0 or grains.os_family in ('Arch', 'MacOS') %}
                {%- for cmd in d.pkg.compose.commands|unique %}

docker-compose-software-binary-install-symlink-{{ cmd }}:
  file.symlink:
    - name: /usr/local/bin/{{ cmd }}
    - target: {{ d.pkg.compose.path }}/{{ cmd }}
    - force: True
    - onchanges:
      - file: docker-compose-software-binary-install
    - require:
      - file: docker-compose-software-binary-install

                {%- endfor %}
            {%- endif %}
        {%- endif %}
    {%- else %}

docker-compose-software-binary-install-other:
  test.show_notification:
    - text: |
        The docker-compose binary is unavailable/unselected for {{ salt['grains.get']('finger', grains.os_family) }}

    {%- endif %}

