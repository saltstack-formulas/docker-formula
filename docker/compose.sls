{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import docker with context %}

include:
  - docker

docker-compose:
      {%- if grains.os_family in ('Suse',) %}   ##workaround https://github.com/saltstack-formulas/docker-formula/issues/198
  cmd.run:
    - name: /usr/bin/pip install docker-compose
      {%- else %}
  pip.installed:
         {%- if 'compose_version' in docker and docker.compose_version %}
    - name: docker-compose == {{ docker.compose_version }}
         {%- else %}
    - name: docker-compose
         {%- endif %}
         {%- if docker.proxy %}
    - proxy: {{ docker.proxy }}
         {%- endif %}
    - reload_modules: True
      {%- endif %}
    - require:
      - pkg: docker-package-dependencies
