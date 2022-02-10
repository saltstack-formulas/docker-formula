.. _readme_apt_keyrings:

apt repositories' keyrings
==========================

Debian family of OSes deprecated the use of `apt-key` to manage repositories' keys
in favor of using `keyring files` which contain a binary OpenPGP format of the key
(also known as "GPG key public ring")

As docker don't provide such key files, we created them following the
official recomendations in their sites and install the resulting files.

See https://docs.docker.com/engine/install/debian/#install-using-the-repository for details

.. code-block:: bash

   $ curl -fsSL https://download.docker.com/linux/debian/gpg | \
       gpg --dearmor --output docker-archive-keyring.gpg
