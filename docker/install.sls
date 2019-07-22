{% from "docker/map.jinja" import docker with context %}

{%- set docker_pkg_name = docker.pkg.old_name if docker.use_old_repo else docker.pkg.name %}
{%- set docker_pkg_version = docker.version | default(docker.pkg.version) %}
{%- set docker_packages = docker.kernel.pkgs + docker.pkgs %}
{%- set python_major = grains['pythonversion'][0] | string %}
{%- set python_minor = grains['pythonversion'][1] | string %}

include:
  - .kernel
  - .repo

docker-package-dependencies:
  pkg.installed:
    - pkgs:
        {%- for pkgname in docker_packages %}
      - {{ pkgname }}
        {%- endfor %}
        {%- if "pip" in docker and "pkgname" in docker.pip %}
      - {{ docker.pip.pkgname }}
        {%- endif %}
    - unless: test "`uname`" = "Darwin"
    - refresh: {{ docker.refresh_repo }}

docker-package:
  pkg.installed:
    - name: {{ docker_pkg_name }}
    - version: {{ docker_pkg_version or 'latest' }}
    - refresh: {{ docker.refresh_repo }}
    - require:
      - pkg: docker-package-dependencies
        {%- if grains['os']|lower not in ('amazon', 'fedora', 'suse',) %}
    - pkgrepo: docker-package-repository
        {%- endif %}
        {%- if grains['os']|lower not in ('suse',) %}
    - allow_updates: {{ docker.pkg.allow_updates }}
    - hold: {{ docker.pkg.hold }}
        {%- endif %}
        {%- if grains.os_family in ('Suse',) %}   ##workaround https://github.com/saltstack-formulas/docker-formula/issues/198
  cmd.run:
    - name: /usr/bin/pip{{ python:major }}.{{ python_minor }} install {{ '--upgrade' if docker.pip.upgrade else '' }} pip
        {%- else %}
  pip.installed:
    - name: pip
    - bin_env: /usr/bin/pip{{ python_major }}.{{ python_minor }}
    - reload_modules: true
    - upgrade: {{ docker.pip.upgrade }}
        {%- endif %}
    - onlyif: {{ docker.pip.install_pypi_pip }}  #### onlyif you really need pypi pip instead of using official distro pip.
    - require:
      - pkg: docker-package-dependencies

  {%- if grains.os != 'MacOS' %}
docker-config:
  file.managed:
    - name: {{ docker.configfile }}
    - source: salt://docker/files/config
    - template: jinja
    - mode: 644
    - user: root
    - require:
      - pkg: docker-package
    - watch_in:
      - service: docker-service
  {%- endif %}

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
      - pkg: docker-package
        {% if docker.daemon_config %}
      - file: docker-daemon-config
        {% endif %}
        {% if "process_signature" in docker %}
    - sig: {{ docker.process_signature }}
        {% endif %}

{% if docker.install_docker_py %}
docker-py:
        {%- if grains.os_family in ('Suse',) %}   ##workaround https://github.com/saltstack-formulas/docker-formula/issues/198
  cmd.run:
    - name: /usr/bin/pip{{ python_major }}.{{ python_minor }} install {{ docker.python_package }}
        {%- else %}
  pip.installed:
            {%- if "python_package" in docker %}
    - name: {{ docker.python_package }}
            {%- elif "pip_version" in docker %}
    - name: docker-py {{ docker.pip_version }}
            {%- else %}
    - name: docker-py
            {%- endif %}
    - bin_env: /usr/bin/pip{{ python_major }}.{{ python_minor }}
    - reload_modules: true
            {%- if docker.proxy %}
    - proxy: {{ docker.proxy }}
            {%- endif %}
    - require:
      - pkg: docker-package-dependencies
        {%- endif %}
{% endif %}
