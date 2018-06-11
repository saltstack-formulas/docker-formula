{% from "docker/map.jinja" import docker with context %}

docker-compose-pip:
  pkg.installed:
    - name: python-pip
    - require_in:
      - pkg: docker-compose

docker-compose:
  pip.installed:
    {%- if docker.compose_version %}
    - name: docker-compose == {{ docker.compose_version }}
    {%- else %}
    - name: docker-compose
    {%- endif %}
