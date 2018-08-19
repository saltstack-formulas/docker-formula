{% from "docker/map.jinja" import docker with context %}

include:
  - docker

docker-compose-pip:
  pkg.installed:
    - name: {{ docker.pip.pkgname }}
    - require_in:
      - pip: docker-compose

docker-compose:
  pip.installed:
    {%- if docker.compose_version %}
    - name: docker-compose == {{ docker.compose_version }}
    {%- else %}
    - name: docker-compose
    {%- endif %}
    {%- if docker.proxy %}
    - proxy: {{ docker.proxy }}
    {%- endif %}
