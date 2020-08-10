{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import networks with context %}

include:
  - docker

{%- for networkname in networks %}
{{ networkname }} network:
  docker_network.present:
    - name: {{ networkname }}
{%- endfor %}
