======
Docker
======

Formulas for working with Docker

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``docker``
----------

Install and run Docker daemon

.. note::

    On Ubuntu 12.04 state will also update kernel if needeed
    (as mentioned in `docker installation docs <https://docs.docker.com/installation/ubuntulinux/>`_).
    You should manually reboot minions for kernel update to take affect.
    
    You can override the default docker daemon options by setting each line in the *"docker-pkg:lookup:config"* pillar. This effectively writes the config in */etc/default/docker*. See *pillar.example*


``docker.containers``
---------------------

Pulls and runs a number of docker containers with arbitrary *run* options all configurable via pillars.
Salt includes *dockerio* and *dockerng* states, but both depend on *docker-py* library, which not always implements the latest *docker run* options. This gives the user more control over the docker run options, but it doesn't try to implement all the other docker commands, such as build, ps, inspect, etc. It just pulls an image and runs it.

To use it, just include *docker.containers* in your *top.sls*, and configure it using pillars:

::

  docker-containers:
    lookup:
      mycontainer:
        image: "my_image"
        cmd:
        runoptions:
          - "-e MY_ENV=warn"
          - "--log-driver=syslog"
          - "-p 2345:2345"
          - "--rm"
      myapp:
        image: "myregistry.com:5000/training/app:3.0"
        cmd:  python app.py
        runoptions:
          - "--log-driver=syslog"
          - "-v /mnt/myapp:/myapp"
          - "-p 80:80"
          - "--rm"
        stopoptions:
          - -t 60


In the example pillar above:

- *mycontainer* and *myapp* are the container names (ie *--name* option).
- Upstart files are created for each container, so ``service <container_name> stop|start|status`` should just work
- ``service <container_name> stop`` will wipeout the container completely (ie ``docker stop <container_name> + docker rm <container_name>``)


``docker.compose``
------------------

Add support for using `Docker Compose <https://docs.docker.com/compose/>`_
(previously ``fig``) to define groups of containers and their relationships
with one another.

``docker.compose-ng``
---------------------

The intent is to provide an interface similar to the `specification <https://docs.docker.com/compose/yml/>`_
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
which can not be represented with the ``docker.running`` state interface
since they are not intended to include a long living service inside the
container.

See the included ``pillar.example`` for a representative pillar data block.

To use this formula, you might target a host with the following pillar:

.. code:: yaml

    docker:
      compose:
        registry-data:
          dvc: True
          image: &registry_image 'library/registry:0.9.1'
          container_name: &dvc 'registry-999-99-data'
          command: echo *dvc data volume container
          volumes:
            - &datapath '/registry'
        registry-service:
          image: *registry_image
          container_name: 'registry-999-99-service'
          restart: 'always'
          volumes_from:
            - *dvc
          environment:
            SETTINGS_FLAVOR: 'local'
            STORAGE_PATH: *datapath
            SEARCH_BACKEND: 'sqlalchemy'
        nginx:
          image: 'library/nginx:1.9.0'
          container_name: 'nginx-999-99'
          restart: 'always'
          links:
            - 'registry-999-99-service:registry'
          ports:
            - '80:80'
            - '443:443'

Then you would target a host with the following states:

.. code:: yaml

    include:
      - base: docker
      - base: docker.compose-ng


``docker.registry (DEPRECATED)``
--------------------------------

NEW:

Since the more generic *docker-container* above has been implemented, the *docker-registry* state can now be deprecated. The registry is just another docker image, we can use *docker-container* with a pillar similar to this:

::

  docker-containers:
    lookup:
      registry:
        image: "registry:2"
        cmd:
        runoptions:
          - "-e REGISTRY_STORAGE=s3"
          - "-e REGISTRY_STORAGE_S3_REGION=us-west-1"
          - "-e REGISTRY_STORAGE_S3_BUCKET=my-bucket"
          - "-e REGISTRY_STORAGE_S3_ROOTDIRECTORY=my_registry/folder"
          - "--log-driver=syslog"
          - "-p 5000:5000"
          - "--rm"

-----

OLD:

IMPORTANT: docker.registry will eventually be removed.

Run a Docker container to start the registry service.

If *"registry:lookup:version"* pillar is either the string "latest" or not specified at all, it defaults to the "latest" image tag, which at the time of this writing is still pointing to 0.9.1, even though 2.x is out for a while. It still uses the old registry pillar configuration for backwards compatibility. See the commented out block in *pillar.example*

If *"registry:lookup:version"* is set to any other version, e.g. *2*, an image with that tag will be downloaded and the new pillar configuation should be used. See *pillar.example*.

In this case, extra *docker run* options can be provided in your *"registry:lookup:runoptions"* pillar to provide environment variables, volumes, or log configuration to the container.

By default, the storage backend used by the registry is "filesystem". Use environment variables to override that, for example to use S3 as backend storage.

