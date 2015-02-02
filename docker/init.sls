docker-python-apt:
  pkg.installed:
    - name: python-apt

{% if grains['lsb_distrib_release'] == '12.04' -%}
{% set minimal_kernel_version = '3.8' -%}
docker-dependencies-kernel:
  pkg.installed:
    - pkgs:
      - linux-image-generic-lts-raring
      - linux-headers-generic-lts-raring
    - require_in:
      - pkg: lxc-docker
    - onlyif: dpkg --compare-versions {{ grains['kernelrelease'] }} lt {{ minimal_kernel_version }}

# Force cgroup-lite on 12.04, 'cause docker do not work with cgroup-bin, 
# which is installed by default
cgroup-lite:
  pkg.installed:
    - require_in:
      - pkg: docker-dependencies
{% endif %}

docker-dependencies:
   pkg.installed:
    - pkgs:
      - iptables
      - ca-certificates
      - lxc

docker-repo:
    pkgrepo.managed:
      - repo: 'deb http://get.docker.io/ubuntu docker main'
      - file: '/etc/apt/sources.list.d/docker.list'
      - key_url: salt://docker/docker.pgp
      - require_in:
          - pkg: lxc-docker
      - require:
        - pkg: docker-python-apt

lxc-docker:
  pkg.latest:
    - require:
      - pkg: docker-dependencies

docker-service:
  service.running:
    - name: docker
    - enable: True
