# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "docker/map.jinja" import docker with context %}

docker-packages-cleaned-service-dead:
  service.dead:
    - name: docker
    {% if "process_signature" in docker %}
    - sig: {{ docker.process_signature }}
    - onlyif: ps -ef | grep "{{ docker.process_signature }}" ##stop stderr from sig
    {% endif %}
    - require_in:
      - pkg: docker-packages-cleaned

docker-packages-cleaned:
  pkg.removed:
    - pkgs:
      - {{ docker.pkg.old_name if docker.use_old_repo else docker.pkg.name }}
      - docker
      - docker.io
      - docker-client
      - docker-client-latest
      - docker-common
      - docker-latest
      - docker-latest-logrotate
      - docker-logrotate
      - docker-selinux
      - docker-engine-selinux
      - docker-engine
   {%- for pkgname in docker.pkgs %}
      - {{ pkgname }}
   {%- endfor %}

{# remove pip packages installed by formula #}

docker-pips-removed:
  pip.removed:
    - onlyif: python -m pip --version >/dev/null 2>&1
    - names:
         {% if docker.compose_version -%}
      - docker-compose == {{ docker.compose_version }}
         {% else -%}
      - docker-compose
         {% endif -%}
         {% if docker.install_docker_py -%}
            {% if "python_package" in docker -%}
      - {{ docker.python_package }}
            {% elif "pip_version" in docker -%}
      - docker-py {{ docker.pip_version }}
            {% else -%}
      - docker-py
            {%- endif -%}
         {% endif %}
       {%- if docker.proxy %}
    - proxy: {{ docker.proxy }}
       {%- endif %}
