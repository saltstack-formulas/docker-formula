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


``docker.registry``
-------------------

Run a Docker container to start the registry service using AWS S3 to store the images.

It requires the docker state and the `python-formula <https://github.com/TeamLovely/python-formula>`_.
