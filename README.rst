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


In the example pillar above:

- *mycontainer* and *myapp* are the container names (ie *--name* option).
- Upstart files are created for each container, so ``service <container_name> stop|start|status`` should just work
- ``service <container_name> stop`` will wipeout the container completely (ie ``docker stop <container_name> + docker rm <container_name>``)

``docker.registry (DEPRECATED)``
--------------------------------

NEW:

Since the more generic *docker-container* above has been implemented, the *docker-registry* state can now be deprecated. Since the registry is just another docker image, we can use *docker-container* with a pillar similar to this:

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

``docker.compose``
------------------

Add support for using `Docker Compose <https://docs.docker.com/compose/>`_
(previously ``fig``) to define groups of containers and their relationships
with one another.

