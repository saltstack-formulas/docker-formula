{% from "docker/map.jinja" import containers with context %}

{% for name, container in containers.items() %}
docker-image-{{ name }}:
  cmd.run:
    - name: docker pull {{ container.image }}
    - require:
      - service: docker-service

docker-container-startup-config-{{ name }}:
  file.managed:
    - name: /etc/init/docker-{{ name }}.conf
    - source: salt://docker/files/upstart.conf
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
