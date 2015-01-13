file-registry-upstart-conf:
  file.managed:
    - name: /etc/init/registry.conf
    - source: salt://docker/files/upstart.conf
    - mode: 700
    - user: root
    - template: jinja
    - require:
      - cmd: cmd-registry-image-pull

cmd-registry-image-pull:
  cmd.run:
    - name: docker pull registry
    - require:
      - service: docker-service

service-registry:
  service.running:
    - name: registry
    - enable: True
    - watch:
      - file: file-registry-upstart-conf
    - require:
      - pip: pip-sqlalchemy

pip-sqlalchemy:
  pip.installed:
    - name: sqlalchemy
    - require:
      - pkg: python2
