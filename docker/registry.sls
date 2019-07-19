{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import docker with context %}

file-registry-upstart-conf:
  file.managed:
    - name: /etc/init/registry.conf
    - source: salt://docker/files/upstart.conf.deprecated.registry
    - mode: 700
    - user: root
    - template: jinja
    - require:
      - cmd: cmd-registry-image-pull

cmd-registry-image-pull:
  cmd.run:
    - name: docker pull registry:{{ registry.version }}
    - require:
      - service: docker-service

service-registry:
  service.running:
    - name: registry
    - enable: True
    - watch:
      - file: file-registry-upstart-conf
