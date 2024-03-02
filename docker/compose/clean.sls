# -*- coding: utf-8 -*-
# vim: ft=sls
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- set sls_docker_software_clean = tplroot ~ '.software.clean' %}
{%- set sls_compose_software_clean = tplroot ~ '.compose.software.clean' %}
include:
  - {{ sls_compose_software_clean }}

{%- for name, container in d.compose.ng.items() %}

docker-compose-ng-{{ container.container_name|d(name) }}-{{ loop.index }}-stopped:
  docker_container.stopped:
    - name: {{ container.container_name|d(name) }}
    - onlyif: docker container inspect {{ container.container_name|d(name) }}
    - require_in:
      - sls: {{ sls_compose_software_clean }}

docker-compose-ng-{{ container.image }}-{{ loop.index }}-absent:
  docker_image.absent:
    - name: {{ container.image }}
    - require_in:
      - sls: {{ sls_compose_software_clean }}

{% endfor %}
