{% from "docker/map.jinja" import docker with context %}

{% if docker.fluentd_log %}
/etc/systemd/system/docker.service:
  file.managed:
    - source: salt://docker/files/docker.service
    - user: root
    - group: root
    - mode: 644
{% else %}
delete /etc/systemd/system/docker.service:
  file.absent:
    - name: /etc/systemd/system/docker.service
{% endif %}

reload_systemd_daemon:
  cmd.run:
    - name: /bin/systemctl daemon-reload
    - watch:
      - file: /etc/systemd/system/docker.service   

restart_docker_daemon:
  cmd.run:
    - name: /bin/systemctl stop docker && /bin/systemctl start docker
    - require:
      - cmd: reload_systemd_daemon
    - watch:
      - cmd: reload_systemd_daemon
