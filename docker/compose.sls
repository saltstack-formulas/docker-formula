{% from "docker/map.jinja" import docker with context %}

include:
  - docker

docker-compose:
  pip.installed:
    {%- if docker.compose_version %}
    - name: docker-compose == {{ docker.compose_version }}
    {%- else %}
    - name: docker-compose
    {%- endif %}
    {%- if docker.proxy %}
    - proxy: {{ docker.proxy }}
    {%- endif %}
    - require:
      - pip: docker-package-dependencies
      - pkg: docker-package-dependencies
    - reload_modules: {{ docker.refresh_repo }}
