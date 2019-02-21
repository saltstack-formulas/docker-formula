{% from "docker/map.jinja" import docker with context %}

include:
  - docker

docker-compose:
      {%- if grains.os_family in ('Suse',) %}   ##workaround https://github.com/saltstack-formulas/docker-formula/issues/198
  cmd.run:
    - name: /usr/bin/pip install docker-compose
      {%- else %}
  pip.installed:
         {%- if docker.compose_version %}
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
