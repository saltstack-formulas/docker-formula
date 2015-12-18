{% from "docker/map.jinja" import docker with context %}
{% if docker.kernel is defined %}
include:
  - .kernel
{% endif %}

docker package dependencies:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - iptables
      - ca-certificates
      - lxc
      - python-apt

{%- if grains["oscodename"]|lower == 'jessie' %}
docker package repository:
  pkgrepo.managed:
    - name: deb http://http.debian.net/debian jessie-backports main
{%- else %}
{%- if "version" in docker and docker.version < '1.7.1' %}
docker package repository:
  pkgrepo.managed:
    - name: deb https://get.docker.com/ubuntu docker main
    - humanname: Old Docker Package Repository
    - keyid: d8576a8ba88d21e9
{%- else %}
purge old packages:
  pkgrepo.absent:
    - name: deb https://get.docker.com/ubuntu docker main
  pkg.purged:
    - name: lxc-docker*
    - require_in:
      - pkgrepo: docker package repository

docker package repository:
  pkgrepo.managed:
    - name: deb https://apt.dockerproject.org/repo {{ grains["os"]|lower }}-{{ grains["oscodename"] }} main
    - humanname: {{ grains["os"] }} {{ grains["oscodename"]|capitalize }} Docker Package Repository
    - keyid: f76221572c52609d
{%- endif %}
    - keyserver: keyserver.ubuntu.com
    - file: /etc/apt/sources.list.d/docker.list
    - refresh_db: True
{%- endif %}
    - require_in:
      - pkg: docker package
    - require:
      - pkg: docker package dependencies

docker package:
  {%- if "version" in docker %}
  pkg.installed:
    {%- if grains["oscodename"]|lower == 'jessie' %}
    - name: docker.io
    - version: {{ docker.version }}
    {%- elif  docker.version < '1.7.1' %}
    - name: lxc-docker-{{ docker.version }}
    {%- else %}
    - name: docker-engine
    - version: {{ docker.version }}
    {%- endif %}
  {%- else %}
  pkg.latest:
    {%- if grains["oscodename"]|lower == 'jessie' %}
    - name: docker.io
    {%- else %}
    - name: docker-engine
    {%- endif %}
  {%- endif %}
    - refresh: {{ docker.refresh_repo }}
    - require:
      - pkg: docker package dependencies
      - pkgrepo: docker package repository
      - file: docker-config

docker-config:
  file.managed:
    - name: /etc/default/docker
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
    - name: python-pip
  pip.installed:
    - name: pip
    - upgrade: True

docker-py:
  pip.installed:
    {%- if "pip_version" in docker %}
    - name: docker-py {{ docker.pip_version }}
    {%- else %}
    - name: docker-py
    {%- endif %}
    - require:
      - pkg: docker package
      - pip: docker-py requirements
    - reload_modules: True
{% endif %}
