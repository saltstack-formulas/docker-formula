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

``docker.registry``
-------------------

Run a Docker container to start the registry service using AWS S3 to store the images.

It requires the docker state and the `python-formula <https://github.com/TeamLovely/python-formula>`_.

``docker.compose``
------------------

Add support for using `Docker Compose <https://docs.docker.com/compose/>`_
(previously ``fig``) to define groups of containers and their relationships
with one another.
