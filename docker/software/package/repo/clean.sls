# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- if 'repo' in d.pkg.docker and d.pkg.docker.repo %}

docker-software-package-repo-absent:
    {%- if grains.os_family != 'Debian' %}
  pkgrepo.absent:
    - name: {{ d.pkg.docker.repo.name | yaml_dquote }}

    {%- else %}
    # Due to this bug https://github.com/saltstack/salt/issues/51656#issuecomment-1032882625
    # we should delete the repo file using other method
  file.absent:
    - name: {{ d.pkg.docker.repo.file }}

docker-software-package-repo-keyring-absent:
  file.absent:
    - name: {{ d.pkg.docker.repo_keyring }}
    {%- endif %}

{%- endif %}
