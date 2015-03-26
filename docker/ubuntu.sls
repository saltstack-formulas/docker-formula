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
{% endif %}
