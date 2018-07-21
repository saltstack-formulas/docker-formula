{% from "docker/map.jinja" import docker with context %}

{% set docker_pkg_name = docker.pkg.old_name if docker.use_old_repo else docker.pkg.name %}
{% set docker_pkg_version = docker.version | default(docker.pkg.version) %}
include:
  - .kernel
  - .repo

docker package dependencies:
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

docker package:
  pkg.installed:
    - name: {{ docker_pkg_name }}
    - version: {{ docker_pkg_version }}
    - refresh: {{ docker.refresh_repo }}
    - require:
      - pkg: docker package dependencies
      {%- if grains['os']|lower not in ('amazon', 'fedora', 'suse',) %}
      - pkgrepo: docker package repository
      {%- endif %}
    - refresh: {{ docker.refresh_repo }}
    - require:
      - pkg: docker package dependencies
      {%- if grains['os']|lower not in ('amazon', 'fedora', 'suse',) %}
      - pkgrepo: docker package repository
      {%- endif %}
    - require_in:

# docker package:
#   pkg.installed:
#     {%- if grains["oscodename"]|lower == 'jessie' %}
#     - name: docker.io
#     - fromrepo: {{ docker.kernel.pkg.fromrepo }}
#     {%- elif use_old_repo is defined %}
#     - name: lxc-docker
#     {%- else %}
#       {%- if grains['os']|lower in ('amazon', 'fedora', 'suse',) %}
#     - name: docker
#       {%- else %}
#     - name: docker-engine
#       {%- endif %}
#     {%- endif %}
#     - refresh: {{ docker.refresh_repo }}
#     - require:
#       - pkg: docker package dependencies
#       {%- if grains['os']|lower not in ('amazon', 'fedora', 'suse',) %}
#       - pkgrepo: docker package repository
#       {%- endif %}
#     - require_in:
#       - file: docker-config
#     - allow_updates: {{ docker.pkg.allow_updates }}
#       {% if docker.pkg.version %}
#     - version: {{ docker.pkg.version }}
#       {% elif "version" in docker %}
#     - version: {{ docker.version }}
#       {% endif %}
#       {% if docker.pkg.hold %}
#     - hold: {{ docker.pkg.hold }}
#       {% endif %}

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
      - pkg: docker package
    {% if "process_signature" in docker %}
    - sig: {{ docker.process_signature }}
    {% endif %}

{% if docker.install_docker_py %}
docker-py requirements:
  pkg.installed:
    - name: {{ docker.python_pip_package }}

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
{% endif %}
