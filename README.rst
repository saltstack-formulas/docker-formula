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

Install and run Docker

.. note::

    On Ubuntu 12.04 state will also update kernel if needeed
    (as mentioned in `docker installation docs <https://docs.docker.com/installation/ubuntulinux/>`_).
    You should manually reboot minions for kernel update to take affect.
    
    You can override the default docker daemon options by setting each line in the *"docker-pkg:lookup:config"* pillar. This effectively writes the config in */etc/default/docker*. See *pillar.example*

``docker.registry``
-------------------

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

