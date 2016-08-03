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
      - python-apt

{%- if grains["oscodename"]|lower == 'jessie' and "version" not in docker%}
docker package repository:
  pkgrepo.managed:
    - name: deb http://http.debian.net/debian jessie-backports main
{%- else %}
  {%- if "version" in docker %}
    {%- if (docker.version|string).startswith('1.7.') %}
      {%- set use_old_repo = docker.version < '1.7.1' %}
    {%- else %}
      {%- set version_major = (docker.version|string).split('.')[0]|int %}
      {%- set version_minor = (docker.version|string).split('.')[1]|int %}
      {%- set old_repo_major = 1 %}
      {%- set old_repo_minor = 7 %}
      {%- set use_old_repo = (version_major < old_repo_major or (version_major == old_repo_major and version_minor < old_repo_minor)) %}
    {%- endif %}
  {%- endif %}

{%- if "version" in docker and use_old_repo %}
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
    - pkgs: 
      - lxc-docker*
      - docker.io*
    - require_in:
      - pkgrepo: docker package repository

docker package repository:
  pkgrepo.managed:
    - name: deb https://apt.dockerproject.org/repo {{ grains["os"]|lower }}-{{ grains["oscodename"] }} main
    - humanname: {{ grains["os"] }} {{ grains["oscodename"]|capitalize }} Docker Package Repository
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D
{%- endif %}
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
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
    {%- if grains["oscodename"]|lower == 'jessie' and "version" not in docker %}
    - name: docker.io
    - version: {{ docker.version }}
    {%- elif use_old_repo %}
    - name: lxc-docker-{{ docker.version }}
    {%- else %}
    - name: docker-engine
    - version: {{ docker.version }}
    {%- endif %}
    - hold: True
  {%- else %}
  pkg.latest:
    {%- if grains["oscodename"]|lower == 'jessie' and "version" not in docker %}
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

{% if salt['grains.has_value']('systemd') %}
docker-unit-drop-in:
  file.managed:
    - name: /etc/systemd/system/docker.service.d/docker-defaults.conf
    - source: salt://docker/files/systemd.drop-in
    - makedirs: True
    - require:
      - file: docker-config

reload-systemd:
  module.wait:
    - name: service.systemctl_reload
    - watch:
      - file: docker-unit-drop-in
{% endif %}

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
    {%- if "pip" in docker and "version" in docker.pip %}
    - name: pip {{ docker.pip.version }}
    {%- else %}
    - name: pip
    - upgrade: True
    {%- endif %}

docker-py:
  pip.installed:
    {%- if "pip_version" in docker %}
    - name: docker-py {{ docker.pip_version }}
    {%- else %}
    - name: docker-py
    {%- endif %}
    - reload_modules: true
{% endif %}
