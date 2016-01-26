{% from "docker/map.jinja" import docker with context %}

{% if docker.fluentd_log is defined %}
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
