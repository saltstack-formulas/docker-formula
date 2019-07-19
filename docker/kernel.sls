{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import docker with context %}

{%- if docker.kernel is defined and grains['os_family']|lower == 'debian' %}
pkgrepo-dependencies:
  pkg.installed:
    - name: python-apt

  {% if "pkgrepo" in docker.kernel %}
{{ grains["oscodename"]|lower }}-backports-repo:
  pkgrepo.managed:
    {% for key, value in docker.kernel.pkgrepo.items() %}
    - {{ key }}: {{ value }}
    {% endfor %}
    - require:
      - pkg: python-apt
    - onlyif: dpkg --compare-versions {{ grains["kernelrelease"] }} lt 3.8
  {% endif %}

  {% if "pkg"  in docker.kernel %}
docker-dependencies-kernel:
  pkg.installed:
    {% for key, value in docker.kernel.pkg.items() %}
    - {{ key }}: {{ value }}
    {% endfor %}
    - require_in:
      - pkg: docker-package
    - onlyif: dpkg --compare-versions {{ grains["kernelrelease"] }} lt 3.8
  {% endif %}
{% endif %}
