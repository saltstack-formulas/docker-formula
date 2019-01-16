{% from "docker/map.jinja" import docker with context %}

{% set docker_pkg_name = docker.pkg.old_name if docker.use_old_repo else docker.pkg.name %}
{% set docker_pkg_version = docker.version | default(docker.pkg.version) %}

{%- set docker_packages = docker.kernel.pkgs + docker.pkgs %}

include:
  - .kernel
  - .repo

docker-package-dependencies:
  pkg.installed:
    - pkgs:
       {%- for pkgname in docker_packages %}
      - {{ pkgname }}
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
  pip.installed:
    - name: pip
    - onlyif: {{ docker.install_pypi_pip }}
    - reload_modules: true
    - require:
      - pkg: docker-package-dependencies

docker-config:
  file.managed:
    - name: {{ docker.configfile }}
    - source: salt://docker/files/config
    - template: jinja
    - mode: 644
    - user: root

{% if docker.daemon_config %}
docker-daemon-dir:
  file.directory:
    - name: /etc/docker
    - user: root
    - group: root
    - mode: 755

docker-daemon-config:
  file.serialize:
    - name: /etc/docker/daemon.json
    - user: root
    - group: root
    - mode: 644
    - dataset:
        {{ docker.daemon_config | yaml() | indent(8) }}
    - formatter: json
{% endif %}

docker-service:
  service.running:
    - name: docker
    - enable: True
    - watch:
      - file: docker-config
      - pkg: docker-package
      {% if docker.daemon_config %}
      - file: docker-daemon-config
      {% endif %}
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
    - reload_modules: true
    {%- if docker.proxy %}
    - proxy: {{ docker.proxy }}
    {%- endif %}
    - require:
      - pkg: docker-package-dependencies
{% endif %}
