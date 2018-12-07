{% from "docker/map.jinja" import docker with context %}

{% set docker_pkg_name = docker.pkg.old_name if docker.use_old_repo else docker.pkg.name %}
{% set docker_pkg_version = docker.version | default(docker.pkg.version) %}
include:
  - .kernel
  - .repo

docker-package-dependencies:
  pip.installed:
    - name: pip
    - onlyif: {{ docker.use_pypi_pip }}
    - reload_modules: {{ docker.refresh_repo }}
  pkg.installed:
    {% for pkgname in [docker.kernel.pkgs] + [docker.pkgs] %}
    - name: {{ pkgname }}
    {%- endfor %}
    {%- if "pkgname" in docker.pip %}
    - {{ docker.pip.pkgname }}
    {%- endif %}
    - unless: test "`uname`" = "Darwin"
    - refresh: {{ docker.refresh_repo }}

docker-package:
  pkg.installed:
    - name: {{ docker_pkg_name }}
    - version: {{ docker_pkg_version }}
    - refresh: {{ docker.refresh_repo }}
    - require:
      - pkg: docker-package-dependencies
      {%- if grains['os']|lower not in ('amazon', 'fedora', 'suse',) %}
      - pkgrepo: docker-package-repository
      {%- endif %}
    - refresh: {{ docker.refresh_repo }}
    - require:
      - pkg: docker-package-dependencies
      {%- if grains['os']|lower not in ('amazon', 'fedora', 'suse',) %}
      - pkgrepo: docker-package-repository
      {%- endif %}
    - require_in:

docker-config:
  file.managed:
    - name: {{ docker.configfile }}
    - source: salt://docker/files/config
    - template: jinja
    - mode: 644
    - user: root

docker-service:
  service.running:
    - name: docker
    - enable: True
    - watch:
      - file: /etc/default/docker
      - pkg: docker-package
    {% if "process_signature" in docker %}
    - sig: {{ docker.process_signature }}
    {% endif %}

{% if docker.install_docker_py %}
docker-py:
  pip.installed:
    {%- if "python_package" in docker %}
    - name: {{ docker.python_package }}
    {%- elif "pip_version" in docker %}
    - name: docker-py {{ docker.pip_version }}
    {%- else %}
    - name: docker-py
    {%- endif %}
    - reload_modules: {{ docker.refresh_repo }}
    {%- if docker.proxy %}
    - proxy: {{ docker.proxy }}
    {%- endif %}
    - require:
      - pip: docker-package-dependencies
      - pkg: docker-package-dependencies
{% endif %}
