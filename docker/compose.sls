{% from "docker/map.jinja" import compose with context %}

compose-pip:
  pkg.installed:
    - name: python-pip
  pip.installed:
    - name: pip
    - upgrade: True

compose:
  pip.installed:
    - name: docker-compose == {{ compose.version }}
    - require:
      - pip: compose-pip
    - reload_modules: true
