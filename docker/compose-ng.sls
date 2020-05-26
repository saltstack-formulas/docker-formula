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
    - privileged: {{ container.privileged|default(False) }}
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
  {%- if 'working_dir' in container %}
    - working_dir: {{ container.working_dir }}
  {%- endif %}
  {%- if 'volume_driver' in container %}
    - volume_driver: {{ container.volume_driver }}
  {%- endif %}
  {%- if 'userns_mode' in container %}
    - userns_mode: {{ container.userns_mode }}
  {%- endif %}
  {%- if 'user' in container %}
    - user: {{ container.user }}
  {%- endif %}
  {%- if 'environment' in container and container.environment is iterable %}
    - environment:
    {%- for variable, value in container.environment.items() %}
        - {{ variable }}: {{ value }}
    {%- endfor %}
  {%- endif %}
  {%- if 'ports' in container and container.ports is iterable %}
    - port_bindings:
    {%- for port_mapping in container.ports %}
      {%- if port_mapping is string %}
        {%- set mapping = port_mapping.split(':',2) %}
        {%- if mapping|length < 2 %}
      - "{{ mapping[0] }}"
        {%- elif mapping|length > 2 %}
      - "{{ mapping[0] }}:{{ mapping[1] }}:{{ mapping[-1] }}"
        {%- else %}
      - "{{ mapping[0] }}:{{ mapping[-1] }}"
        {%- endif %}
      {%- elif port_mapping is mapping %}
      - {{ port_mapping }}
      {%- endif %}
    {%- endfor %}
  {%- endif %}
  {%- if 'volumes' in container %}
    - binds:
    {%- for bind in container.volumes %}
      {%- set mapping = bind.rsplit(':', 1) %}
      {%- if mapping|length > 1 %}
        - "{{ mapping[0] }}:{{ mapping[-1] }}"
      {%- else %}
        - "{{ mapping[0] }}"
      {%- endif %}
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
    {%- set policy = container.restart.split(':',1) %}
    {%- if policy|length < 2 %}
    - restart_policy: {{ policy[0] }}
    {%- else %}
    - restart_policy: {{ policy[0] }}:{{ policy[-1] }}
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
