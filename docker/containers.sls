{% from "docker/map.jinja" import containers with context %}

include:
  - docker

{% for name, container in containers.items() %}
docker-image-{{ name }}:
  cmd.run:
    - name: docker pull {{ container.image }}
    - require:
      - service: docker-service

{# TODO: SysV init script #}
{# Use grains instead of command to get init system #}
{%- set init_system = grains['init'] %}

docker-container-startup-config-{{ name }}:
  file.managed:
{%- if init_system == "systemd" %}
    - name: /etc/systemd/system/docker-{{ name }}.service
{%- elif init_system == "upstart" %}
    - name: /etc/init/docker-{{ name }}.conf
{%- endif %}
    - source: salt://docker/files/service_file.jinja
    - mode: 700
    - user: root
    - template: jinja
    - defaults:
        name: {{ name | json }}
        container: {{ container | json }}
    - require:
      - cmd: docker-image-{{ name }}

docker-container-service-{{ name }}:
  service.running:
    - name: docker-{{ name }}
    - enable: True
    - watch:
      - cmd: docker-image-{{ name }}
      - file: docker-container-startup-config-{{ name }}
{% endfor %}
