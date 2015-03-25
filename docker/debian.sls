{% if grains['lsb_distrib_codename'] == 'wheezy' -%}
{% set minimal_kernel_version = '3.8' -%}
wheezy backports repo:
  pkgrepo.managed:
    - name: deb http://http.debian.net/debian wheezy-backports main
    - humanname: Wheezy Backports
    - dist: wheezy-backports
    - require:
      - pkg: python-apt
    - require_in:
      - pkg: linux-image-amd64
    - onlyif: dpkg --compare-versions {{ grains['kernelrelease'] }} lt {{ minimal_kernel_version }}

supported wheezy kernel:
  pkg.installed:
    - name: linux-image-amd64
    - require_in: lxc-docker

{% endif %}
