
{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import docker with context %}

{% set repo_state = 'absent' %}
{% if docker.use_upstream_repo or docker.use_old_repo %}
  {% set repo_state = 'managed' %}
{% endif %}

{% set humanname_old = 'Old ' if docker.use_old_repo else '' %}

{%- if grains['os_family']|lower in ('debian',) %}
{% set url = 'https://apt.dockerproject.org/repo ' ~ grains["os"]|lower ~ '-' ~ grains["oscodename"] ~ ' main' if docker.use_old_repo else docker.repo.url_base ~ ' ' ~ docker.repo.version ~ ' stable' %}

docker-package-repository:
  pkgrepo.{{ repo_state }}:
    - humanname: {{ grains["os"] }} {{ grains["oscodename"]|capitalize }} {{ humanname_old }}Docker Package Repository
    - name: deb [arch={{ grains["osarch"] }}] {{ url }}
    - file: {{ docker.repo.file }}
    {% if docker.use_old_repo %}
    - keyserver: keyserver.ubuntu.com
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D
    {% else %}
    - key_url: {{ docker.repo.key_url }}
    {% endif %}
        {%- if grains['saltversioninfo'] >= [2018, 3, 0] %}
    - refresh: True
        {%- else %}
    - refresh_db: True
        {%- endif %}
    - require_in:
      - pkg: docker-package
    - require:
      - pkg: docker-package-dependencies

{%- elif grains['os_family']|lower in ('redhat',) %}
{% set url = 'https://yum.dockerproject.org/repo/main/centos/$releasever/' if docker.use_old_repo else docker.repo.url_base %}

docker-package-repository:
  pkgrepo.{{ repo_state }}:
    - name: docker-ce-stable
    - humanname: {{ grains['os'] }} {{ grains["oscodename"]|capitalize }} {{ humanname_old }}Docker Package Repository
    - baseurl: {{ url }}
    - enabled: 1
    - gpgcheck: 1
    {% if docker.use_old_repo %}
    - gpgkey: https://yum.dockerproject.org/gpg
    {% else %}
    - gpgkey: {{ docker.repo.key_url }}
    {% endif %}
    - require_in:
      - pkg: docker-package
    - require:
      - pkg: docker-package-dependencies

{%- else %}
docker-package-repository: {}
{%- endif %}
