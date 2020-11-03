# -*- coding: utf-8 -*-
# vim: ft=sls
# formerly compose-ng state

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}
{%- set formula = d.formula %}

include:
  - {{ formula }}.compose.software
  - {{ formula }}.networks

    {%- for name, container in d.compose.ng.items() %}
        {%- set id = container.container_name|d(name) %}
        {%- set required_containers = [] %}
        {%- set required_networks = [] %}

{{ formula }}-compose-ng-{{ id }}-present:
        {%- if 'deps' in d.pkg and d.pkg.deps %}
            {%- if grains.os|lower == 'centos' %}
                # https://github.com/saltstack/salt/issues/58920
  pip.installed:
    - name: docker
            {%- endif %}
  pkg.installed:
    - names: {{ d.pkg.deps|json }}
    - reload_modules: {{ d.misc.reload or true }}
    - require_in:
      - docker_image: {{ formula }}-compose-ng-{{ id }}-present
        {%- endif %}
  docker_image.present:
    - force: {{ d.misc.force_present }}
        {%- if ':' in container.image %}
            {%- set image = container.image.split(':',1) %}
    - name: {{ image[0] }}
    - tag: {{ image[1] }}
        {%- else %}
    - name: {{ container.image }}
        {%- endif %}

{{ formula }}-compose-ng-{{ id }}-running:
  docker_container.running:
    - name: {{ id }}
    - image: {{ container.image }}
    - skip_translate: {{ d.misc.skip_translate }}
    - force: {{ d.misc.force_running }}
    - privileged: {{ container.privileged|default(False) }}
    - interactive: {{ container.stdin_open|default(False) }}
    - tty: {{ container.tty|default(False) }}
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
        {%- if 'networks' in container %}
    - networks:
            {%- for network in container.networks %}
                {%- do required_networks.append(network) %}
      - {{ network }}
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
      - docker_image: {{ formula }}-compose-ng-{{ id }}-present
        {%- if required_containers is defined %}
            {%- for containerid in required_containers %}
      - docker_image: {{ formula }}-compose-ng-{{ id }}-present
            {%- endfor %}
        {%- endif %}
        {%- if required_networks is defined %}
            {%- for networkid in required_networks %}
      - docker_network: {{ formula }}-network-{{ networkid }}-present
            {%- endfor %}
        {%- endif %}

     {% endfor %}
