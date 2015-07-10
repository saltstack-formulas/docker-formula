{% from "docker/map.jinja" import kernel with context %}
{% from "docker/map.jinja" import pkg with context %}

docker-python-apt:
  pkg.installed:
    - name: python-apt

{% if kernel.pkgrepo is defined %}
{{ grains['lsb_distrib_codename'] }}-backports-repo:
  pkgrepo.managed:
    {% for key, value in kernel.pkgrepo.items() %}
    - {{ key }}: {{ value }}
    {% endfor %}
    - require:
      - pkg: python-apt
    - onlyif: dpkg --compare-versions {{ grains['kernelrelease'] }} lt 3.8
{% endif %}

{% if kernel.pkg is defined %}
docker-dependencies-kernel:
  pkg.installed:
    {% for key, value in kernel.pkg.items() %}
    - {{ key }}: {{ value }}
    {% endfor %}
    - require_in:
      - pkg: lxc-docker
    - onlyif: dpkg --compare-versions {{ grains['kernelrelease'] }} lt 3.8
{% endif %}

docker-dependencies:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - iptables
      - ca-certificates
      - lxc

docker-repo:
  pkgrepo.managed:
    - humanname: Docker repo
    - name: deb https://get.docker.com/ubuntu docker main
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: d8576a8ba88d21e9
    - keyserver: keyserver.ubuntu.com
    - refresh_db: True
    - require_in:
        - pkg: lxc-docker
    - require:
      - pkg: docker-python-apt

lxc-docker:
  {% if pkg and 'version' in pkg %}
  pkg.installed:
    - name: lxc-docker-{{ pkg.version }}
  {% else %}
  pkg.latest:
  {% endif %}
    - refresh: {{ pkg.refresh_repo }}
    - fromrepo: docker
    - require:
      - pkg: docker-dependencies

docker-service:
  service.running:
    - name: docker
    - enable: True
    {% if pkg and "process_signature" in pkg %}
    - sig: {{ pkg.process_signature }}
    {% endif %}

docker-py package dependency:
  pkg.installed
    - name: python-pip

docker-py:
  pip.installed:
    {% if pkg and "pip_version" in pkg %}
    - name: docker-py {{ pkg.pip_version }}
    {% endif %}
    - require:
      - pkg: lxc-docker
      - pkg: python-pip
    - reload_modules: True
