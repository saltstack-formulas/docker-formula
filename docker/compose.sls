{% from "docker/map.jinja" import docker with context %}

compose-pip:
  pkg.installed:
    - name: python2-pip
  pip.installed:
    - name: pip
    - upgrade: True

compose:
  pip.installed:
    {%- if docker.compose_version %}
    - name: docker-compose == {{ docker.compose_version }}
    {%- else %}
    - name: docker-compose
    {%- endif %}
