.. _readme:

docker-formula
==============

Extensible formula to manage Docker on MacOS, Windows, and GNU/Linux. Currently supports:

* `software`   Docker (https://docs.docker.com/engine/install)  [all OS]
* `containers` Manage Containers. [all OS]
* `compose`    Compose Containers. [all OS]
* `swarm`      Docker Swarm. [Linux]

The default `docker.software` and `docker.compose.software` states support:

* `archive` Docker-Engine (https://docs.docker.com/engine/install)  [Linux]
* `desktop` Docker-Desktop (https://docs.docker.com/desktop) [Windows, MacOS]
*           Docker-Compose (https://docs.docker.com/compose/install/)  [Linux]

The other states support container managmement.


|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/docker-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/docker-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

A SaltStack formula for Docker on MacOS, GNU/Linux and Windows.

.. contents:: **Table of Contents**
   :depth: 1

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.  If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_. If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``, which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.  See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see :ref:`How to contribute <CONTRIBUTING>` for more details.

Available Meta states
----------------------

.. contents::
   :local:

``docker``
^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This state installs the Docker solution (see https://docs.docker.io)

``docker.clean``
^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

Stop Docker daemon and remove docker packages ('docker', 'docker-engine', 'docker-ce', etc) on Linux. To protect OS integrity, this state won't remove packages listed as dependencies (i.e. python is kept).


``docker.software.package.repo``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Configures the upstream Docker's repo on RedHat/Debian OS.

``docker.software.package.repo.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state removes upstream Docker package repository only, on RedHat/Debian OS.

``docker.software``
^^^^^^^^^^^^^^^^^^^

This state installs Docker (see https://docs.docker.com/engine/install and https://docs.docker.com/desktop/)

``docker.software.service``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state installs Dockerd daemon on Linux (systemd support).

``docker.software.service``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state stops Dockerd daemon on Linux (systemd support).

``docker.software.config``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state overrides default Docker options (i.e. /etc/default/docker)::

  docker:
    pkg:
      docker:
        config:
          - DOCKER_OPTS="-s btrfs --dns 8.8.8.8"
          - export http_proxy="http://172.17.42.1:3128"


``docker.software.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls Docker overrides (i.e. /etc/default/docker).

``docker.software.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state uninstalls Docker software.

``docker.containers``
^^^^^^^^^^^^^^^^^^^^^

Pulls and runs a number of docker containers. See docker container API for docker.containers options::

  docker:
    containers:
      running:
        - prometheus_simple
        - prometheus_detail

      prometheus_simple:
        image: "prom/prometheus:v1.7.1"

      prometheus_detail:
        image: "prom/prometheus:v1.7.1"
        # see https://docker-py.readthedocs.io/en/stable/containers.html


``docker.compose``
^^^^^^^^^^^^^^^^^^

Saltstack `dockercompose module` state support (See https://docs.saltstack.com/en/2018.3/ref/modules/all/salt.modules.dockercompose.html).

``docker.compose.ng``
^^^^^^^^^^^^^^^^^^^^^

The intent is to provide an interface similar to the `specification <https://docs.docker.com/compose/compose-file/>`_
provided by docker-compose. The hope is that you may provide pillar data
similar to that which you would use to define services with docker-compose. The
assumption is that you are already using pillar data and salt formulae to
represent the state of your existing infrastructure.

No real effort had been made to support every possible feature of
docker-compose.  Rather, we prefer the syntax provided by the docker-compose
whenever it is reasonable for the sake of simplicity.

It is worth noting that we have added one attribute which is decidedly absent
from the docker-compose specification. That attribute is ``dvc``. This is a
boolean attribute which allows us to define data only volume containers
which can not be represented with the ``docker.software.service.running`` state
since they are not intended to include a long living service inside the
container.

See the included ``pillar.example`` for a representative pillar data block.
To use this formula, you might target a host with the following pillar:

.. code:: yaml

    docker:
      compose:
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

Then you would target a host with the following states:

.. code:: yaml

    include:
      - base: docker
      - base: docker.compose.ng

``docker.swarm``
^^^^^^^^^^^^^^^^

Saltstack `swarm module` state support (See https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.swarm.html).

``docker.swarm.clean``
^^^^^^^^^^^^^^^^^^^^^^

Opposite of `docker.swarm` state (See https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.swarm.html).

``docker.networks``
^^^^^^^^^^^^^^^^^^

Create docker networks

``docker.networks.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

Remove docker networks


Sub-states
----------

Sub-states are available inside sub-directories.


Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^

Creates the Docker instance and runs the ``docker`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^

Removes the Docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.

