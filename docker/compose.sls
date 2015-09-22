{% from "docker/map.jinja" import compose with context %}

compose-pip-dependencies:
  pip.installed:
    - name: docker-compose == {{ compose.version }}
    - require:
      - pkg: python-pip
    - reload_modules: true
