{% from "docker/map.jinja" import docker with context %}

docker packages cleaned service-dead:
  service.dead:
    - name: docker
    {% if "process_signature" in docker %}
    - sig: {{ docker.process_signature }}
    {% endif %}
    - require_in:
      - pkg: docker packages cleaned

docker packages cleaned:
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
