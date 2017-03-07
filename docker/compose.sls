{% from "docker/map.jinja" import compose with context %}

compose-pip:
  pkg.installed:
    - name: python2-pip
  pip.installed:
    - name: pip
    - upgrade: True

compose:
  pip.installed:
    {%- if "version" in compose %}
    - name: docker-compose == {{ compose.version }}
    {%- else %}
    - name: docker-compose
    {%- endif %}
