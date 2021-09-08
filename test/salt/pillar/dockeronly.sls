# -*- coding: utf-8 -*-
# vim: ft=yaml
---
docker:
  wanted:
    - docker

  pkg:
    docker:
      use_upstream: archive
      service:
        name: docker
        env: HTTP_PROXY=http://YOUR_PROXY_IP_ADDRESS:PROXY_PORT
      environ:
        # yamllint disable-line rule:line-length
        - OPTIONS='-s devicemapper --storage-opt dm.fs=xfs --exec-opt native.cgroupdriver=cgroupfs --selinux-enabled'
        # yamllint enable-line rule:line-length
        - DOCKER_OPTS="-s btrfs --dns 8.8.8.8"
        - export http_proxy="http://172.17.42.1:3128"
      daemon_config:
        insecure-registries: []

  networks:
    - nginxnet

  containers:
    running:
      - nginx
      - prometheus

    nginx:
      image: "nginx:latest"

    prometheus:
      image: "prom/prometheus:v1.7.1"
      env:
        - a=b
        - ping=pong
        - ding=dong
      command:
        - ls
        - ls -l
      auto_remove: true
      blkio_weight: 1000
      cap_add: ["SYS_ADMIN", "MKNOD"]
      dns:
        - 8.8.8.8
        - 8.8.4.4
      dns_search:
        - EXAMPLE.COM
      domainname:
        - EXAMPLE.COM
      entrypoint:
        - ls
        - ls -l
        - ls -last
        - sleep 100
      init: false
      labels:
        - label1
        - label2
        - label3
      mem_limit: 1g
      mem_swappiness: 50
      name: prometheus
      network_disabled: false
      network_mode: host  # bridge or none or container:netcontainer or host
      oom_kill_disable: true
      oom_score_adj: 100
      pid_mode: host
      pids_limit: -1
      privileged: false
      publish_all_ports: true
      read_only: false
      stdin_open: false
      tty: true
      volume_driver: local

    # if you want to your own docker registry, use this
    registry:
      image: "registry:latest"
      env:
        - REGISTRY_LOG_LEVEL=warn
        - REGISTRY_STORAGE=s3
        - REGISTRY_STORAGE_S3_REGION=us-west-1
        - REGISTRY_STORAGE_S3_BUCKET=my-bucket
        - REGISTRY_STORAGE_S3_ROOTDIRECTORY=/registry
      networks:
        - nginxnet
      command:
        - "--log-driver=syslog"
        - "-p 5000:5000"
        - "--rm"

  compose: {}
  swarm: {}
  misc:
    skip_translate: ports
    force_present: false
    force_running: true
