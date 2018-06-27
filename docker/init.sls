{% from "docker/map.jinja" import docker with context %}
{% if docker.kernel is defined %}
include:
  - .kernel
{% endif %}

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

{% set repo_state = 'absent' %}
{% if docker.use_upstream_repo %}
  {% set repo_state = 'managed' %}
{% endif %}

{%- if grains['os_family']|lower == 'debian' %}
{%- if grains["oscodename"]|lower == 'jessie' and "version" not in docker%}
docker package repository:
  pkgrepo.{{ repo_state }}:
    - name: deb http://http.debian.net/debian jessie-backports main
{%- else %}
  {%- if "version" in docker %}
    {%- if (docker.version|string).startswith('1.5.') %}
      {%- set use_old_repo = docker.version < '1.5.1' %}
    {%- else %}
      {%- set version_major = (docker.version|string).split('.')[0]|int %}
      {%- set version_minor = (docker.version|string).split('.')[1]|int %}
      {%- set old_repo_major = 1 %}
      {%- set old_repo_minor = 5 %}
      {%- set use_old_repo = (version_major < old_repo_major or (version_major == old_repo_major and version_minor < old_repo_minor)) %}
    {%- endif %}
  {%- endif %}

{%- if "version" in docker and use_old_repo %}
docker package repository:
  pkgrepo.{{ repo_state }}:
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
  pkgrepo.{{ repo_state }}:
    - name: deb https://apt.dockerproject.org/repo {{ grains["os"]|lower }}-{{ grains["oscodename"] }} main
    - humanname: {{ grains["os"] }} {{ grains["oscodename"]|capitalize }} Docker Package Repository
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D
{%- endif %}
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - file: /etc/apt/sources.list.d/docker.list
    - refresh_db: True
{%- endif %}

{%- elif grains['os_family']|lower in ('redhat', 'suse',) and grains['os']|lower not in ('amazon', 'fedora', 'suse',) %}
docker package repository:
  pkgrepo.{{ repo_state }}:
    - name: docker
    - baseurl: https://yum.dockerproject.org/repo/main/centos/$releasever/
    - gpgcheck: 1
    - gpgkey: https://yum.dockerproject.org/gpg
    - require_in:
      - pkg: docker package
    - require:
      - pkg: docker package dependencies
{%- endif %}

docker package:
  {%- if "version" in docker %}
  pkg.installed:
    {%- if grains["oscodename"]|lower == 'jessie' and "version" not in docker %}
    - name: docker.io
    - version: {{ docker.version }}
    {%- elif use_old_repo %}
    - name: lxc-docker
    {%- else %}
    {%- if grains['os']|lower in ('amazon', 'fedora', 'suse',) %}
    - name: docker
    {%- else %}
    - name: docker-engine
    {%- endif %}
    - version: {{ docker.version }}
    {%- endif %}
    - hold: True
  {%- else %}
  pkg.latest:
    {%- if grains["oscodename"]|lower == 'jessie' and "version" not in docker %}
    - name: docker.io
    {%- else %}
    {%- if grains['os']|lower in ('amazon', 'fedora', 'suse',) %}
    - name: docker
    {%- else %}
    - name: docker-engine
    {%- endif %}
    {%- endif %}
  {%- endif %}
    - refresh: {{ docker.refresh_repo }}
    - require:
      - pkg: docker package dependencies
      {%- if grains['os']|lower not in ('amazon', 'fedora', 'suse',) %}
      - pkgrepo: docker package repository
      {%- endif %}
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
