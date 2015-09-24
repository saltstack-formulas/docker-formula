{% from "docker/map.jinja" import containers with context %}

{% for name, container in containers.items() %}
docker-image-{{ name }}:
  cmd.run:
    - name: docker pull {{ container.image }}
    - unless: docker images | grep {{ container.image }}
    - require:
      - service: docker-service

{%- set systemd = salt['cmd.run']('test -d /etc/systemd/system && echo "yes"') == 'yes' %}

docker-container-startup-config-{{ name }}:
  file.managed:
{%- if systemd %}
    - name: /etc/systemd/system/docker-{{ name }}.service
    - source: salt://docker/files/systemd.conf
{%- else %}
    - name: /etc/init/docker-{{ name }}.conf
    - source: salt://docker/files/upstart.conf
{%- endif %}
    - mode: 700
    - user: root
    - template: jinja
    - defaults:
        name: {{ name }}
        container: {{ container }}
    - require:
      - cmd: docker-image-{{ name }}

docker-container-service-{{ name }}:
  service.running:
    - name: docker-{{ name }}
    - enable: True
    - watch:
      - file: docker-container-startup-config-{{ name }}
{% endfor %}
