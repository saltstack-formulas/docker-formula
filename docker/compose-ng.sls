{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import docker with context %}
{%- from tplroot ~ "/map.jinja" import compose with context %}

include:
  - docker.compose

{%- for name, container in compose.items() %}
  {%- set id = container.container_name|d(name) %}
  {%- set required_containers = [] %}
    {%- if grains['saltversioninfo'] >= [2017, 7, 0]  %}
{{ id }}:
  docker_image.present:
    - force: {{ docker.containers.force_present }}
    {%- else %}
{{ id }} image:
  docker.pulled:
    {%- endif %}
  {%- if ':' in container.image %}
    {%- set image = container.image.split(':',1) %}
    - name: {{ image[0] }}
    - tag: {{ image[1] }}
  {%- else %}
    - name: {{ container.image }}
  {%- endif %}

{{ id }} container:
     {%- if grains['saltversioninfo'] >= [2017, 7, 0] %}
  docker_container.running:
    - skip_translate: {{ docker.containers.skip_translate }}
    - force: {{ docker.containers.force_running }}
     {%- else %}
       {%- if 'dvc' in container and container.dvc %}
  docker.installed:
       {%- else %}
  docker.running:
       {%- endif %}
     {%- endif %}
    - name: {{ id }}
    - image: {{ container.image }}
  {%- if 'command' in container %}
    - command: {{ container.command }}
  {%- endif %}
  {%- if 'environment' in container and container.environment is iterable %}
    - environment:
    {%- for variable, value in container.environment.items() %}
        - {{ variable }}: {{ value }}
    {%- endfor %}
  {%- endif %}
  {%- if 'ports' in container and container.ports is iterable %}
    - ports:
    {%- for port_mapping in container.ports %}
      {%- if port_mapping is string %}
        {%- set mapping = port_mapping.split(':',2) %}
        {%- if mapping|length < 2 %}
      - "{{ mapping[0] }}"
        {%- else %}
      - "{{ mapping[-1] }}/tcp":
            HostPort: "{{ mapping[-2] }}"
            HostIp: "{{ mapping[-3]|d('') }}"
        {%- endif %}
      {%- elif port_mapping is mapping %}
      - {{ port_mapping }}
      {%- endif %}
    {%- endfor %}
  {%- endif %}
  {%- if 'volumes' in container %}
    - volumes:
    {%- for volume in container.volumes %}
      - {{ volume }}
    {%- endfor %}
  {%- endif %}
  {%- if 'volumes_from' in container %}
    - volumes_from:
    {%- for volume in container.volumes_from %}
      {%- do required_containers.append(volume) %}
      - {{ volume }}
    {%- endfor %}
  {%- endif %}
  {%- if 'links' in container %}
    - links:
    {%- for link in container.links %}
      {%- set name, alias = link.split(':',1) %}
      {%- do required_containers.append(name) %}
        {{ name }}: {{ alias }}
    {%- endfor %}
  {%- endif %}
  {%- if 'restart' in container %}
    - restart_policy:
    {%- set policy = container.restart.split(':',1) %}
        Name: {{ policy[0] }}
    {%- if policy|length > 1 %}
        MaximumRetryCount: {{ policy[1] }}
    {%- endif %}
  {%- endif %}
    - require:
         {%- if grains['saltversioninfo'] >= [2017, 7, 0] %}
      - docker_image: {{ id }}
         {%- else %}
      - docker: {{ id }} image
         {%- endif %}
  {%- if required_containers is defined %}
    {%- for containerid in required_containers %}
         {%- if grains['saltversioninfo'] >= [2017, 7, 0] %}
      - docker_image: {{ containerid }}
         {%- else %}
      - docker: {{ containerid }}
         {%- endif %}
    {%- endfor %}
  {%- endif %}
{% endfor %}
