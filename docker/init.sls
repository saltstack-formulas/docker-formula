{% from "docker/map.jinja" import docker with context %}

{% set docker_pkg_name = docker.pkg.old_name if docker.use_old_repo else docker.pkg.name %}
{% set docker_pkg_version = docker.version | default(docker.pkg.version) %}
include:
  - .kernel
  - .repo

docker-package-dependencies:
  pkg.installed:
    - pkgs:
      {%- if grains['os_family']|lower == 'debian' %}
      - apt-transport-https
      - python-apt
      {%- endif %}
      - iptables
      - ca-certificates
      {% if docker.kernel.pkgs is defined %}
        {% for pkg in docker.kernel.pkgs %}
        - {{ pkg }}
        {% endfor %}
      {% endif %}
    - unless: test "`uname`" = "Darwin"

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
docker-py requirements:
  pkg.installed:
    - names:
      - {{ docker.pip.pkgname }}
   {%- for pkgname in docker.pkgs %}
      - {{ pkgname }}
   {%- endfor %}

docker-py:
  pip.installed:
    {%- if "python_package" in docker %}
    - name: {{ docker.python_package }}
    {%- elif "pip_version" in docker %}
    - name: docker-py {{ docker.pip_version }}
    {%- else %}
    - name: docker-py
    {%- endif %}
    - reload_modules: true
    {%- if docker.proxy %}
    - proxy: {{ docker.proxy }}
    {%- endif %}
{% endif %}
