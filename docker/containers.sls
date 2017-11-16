{% from "docker/map.jinja" import containers with context %}

include:
  - docker

{% for name, container in containers.items() %}
docker-image-{{ name }}:
  cmd.run:
    - name: docker pull {{ container.image }}
    - require:
      - service: docker-service

docker-container-startup-config-{{ name }}:
  file.managed:
{%- if grains['init'] == "systemd" %}
    - name: /etc/systemd/system/docker-{{ name }}.service
    - source: salt://docker/files/systemd.conf
{%- elif grains['init'] == "upstart" %}
    - name: /etc/init/docker-{{ name }}.conf
    - source: salt://docker/files/upstart.conf
{%- endif %}
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
      - file: docker-container-startup-config-{{ name }}
{% endfor %}
