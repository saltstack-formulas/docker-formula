# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

    {%- if 'repo' in d.pkg.docker and d.pkg.docker.repo %}
        {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

{% if grains.os_family == 'Debian' %}
docker-software-package-repo-keyring-managed:
  file.managed:
    - name: {{ d.pkg.docker.repo_keyring }}
    - source: {{ files_switch(['docker-archive-keyring.gpg'],
                              lookup='docker-software-package-repo-keyring-managed'
                 )
              }}
    - require_in:
      - pkgrepo: docker-software-package-repo-managed
{%- endif %}


docker-software-package-repo-managed:
  pkgrepo.managed:
    {{- format_kwargs(d.pkg.docker.repo) }}
    - humanname: {{ grains["os"] }} {{ grains["oscodename"]|capitalize }} Docker Package Repository
    - refresh: {{ d.misc.refresh }}

    {%- endif %}
