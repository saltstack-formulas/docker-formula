# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

    {%- if 'repo' in d.pkg.docker and d.pkg.docker.repo %}
        {%- from tplroot ~ "/files/macros.jinja" import format_kwargs with context %}

docker-software-package-repo-absent:
  pkgrepo.absent:
    - name: {{ d.pkg.docker.repo.name }}

        {% if grains.os_family == 'Debian' %}
docker-software-package-repo-keyring-absent:
  file.absent:
    - name: {{ d.pkg.docker.repo_keyring }}
        {%- endif %}

    {%- endif %}
