# -*- coding: utf-8 -*-
# vim: ft=yaml
---
# example docker registry container
# if you want to your own docker registry, use this
docker:
  wanted:
    - docker
    - compose

  pkg:
    docker:
      use_upstream: repo
      config:
        # yamllint disable-line rule:line-length
        - OPTIONS='-s devicemapper --storage-opt dm.fs=xfs --exec-opt native.cgroupdriver=cgroupfs --selinux-enabled'
        # yamllint disable-line rule:line-length
        - DOCKER_OPTS="-s btrfs --dns 8.8.8.8"
        - export http_proxy="http://172.17.42.1:3128"
      daemon_config:
        insecure-registries: []

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

    registry:
      image: "registry:latest"
      env:
        - REGISTRY_LOG_LEVEL=warn
        - REGISTRY_STORAGE=s3
        - REGISTRY_STORAGE_S3_REGION=us-west-1
        - REGISTRY_STORAGE_S3_BUCKET=my-bucket
        - REGISTRY_STORAGE_S3_ROOTDIRECTORY=/registry
      command:
        - "--log-driver=syslog"
        - "-p 5000:5000"
        - "--rm"

  compose:
    ## salt dockercompose module ##
    applications:
      - composetest
    composetest:
      path: /srv/salt/docker/files/composetest/docker-compose.yml

    ## formerly compose-ng state ##
    ng:
      registry-datastore:
        dvc: true
        # image: &registry_image 'docker.io/registry:latest' ## Fedora
        image: &registry_image 'registry:latest'
        container_name: &dvc 'registry-datastore'
        command: echo *dvc data volume container
        volumes:
          - &datapath '/registry'
      registry-service:
        image: *registry_image
        container_name: 'registry-service'
        volumes_from:
          - *dvc
        environment:
          SETTINGS_FLAVOR: 'local'
          STORAGE_PATH: *datapath
          SEARCH_BACKEND: 'sqlalchemy'
          REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY: '/registry'
        ports:
          - 127.0.0.1:5000:5000
        # restart: 'always'    # compose v1.9
        deploy:                # compose v3
          restart_policy:
            condition: on-failure
            delay: 5s
            max_attempts: 3
            window: 120s
      nginx-latest:
        # image: 'docker.io/nginx:latest'  ##Fedora
        image: 'nginx:latest'
        container_name: 'nginx-latest'
        links:
          - 'registry-service:registry'
        ports:
          - '80:80'
          - '443:443'
        volumes:
          - /srv/docker-registry/nginx/:/etc/nginx/conf.d
          - /srv/docker-registry/auth/:/etc/nginx/conf.d/auth
          - /srv/docker-registry/certs/:/etc/nginx/conf.d/certs
        working_dir: '/var/www/html'
        volume_driver: 'local'
        userns_mode: 'host'
        user: 'nginx'
        # restart: 'always'    # compose v1.9
        deploy:                # compose v3
          restart_policy:
            condition: on-failure
            delay: 5s
            max_attempts: 3
            window: 120s

  swarm:
    # Per https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.swarm.html
    joinswarm: {}
    leave_swarm: false
    node_ls: {}
    remove_node: {}
    remove_service: {}
    service_create: {}
    swarm_init: {}
    service_info: {}
    swarm_tokens: true
    update_node: {}

  misc:
    skip_translate: ports
    force_present: false
    force_running: true
