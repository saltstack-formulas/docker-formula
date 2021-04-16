
Changelog
=========

`2.0.0 <https://github.com/saltstack-formulas/docker-formula/compare/v1.1.2...v2.0.0>`_ (2021-04-16)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **service:** change default service name (\ `f8f96f1 <https://github.com/saltstack-formulas/docker-formula/commit/f8f96f1fab80e9edb6e2e86d4df310dc312bf9bb>`_\ )

Tests
^^^^^


* standardise use of ``share`` suite & ``_mapdata`` state [skip ci] (\ `69d7e65 <https://github.com/saltstack-formulas/docker-formula/commit/69d7e65e9f5b6982e758ab0e04d177b16ebd2d7c>`_\ )
* **service:** enable for ``archive`` and ``package`` suites (\ `c168ee1 <https://github.com/saltstack-formulas/docker-formula/commit/c168ee110e80c993869ec38cab6a16782ea60fef>`_\ )

BREAKING CHANGES
^^^^^^^^^^^^^^^^


* **service:** due changes in default service name, on systems
  where 'archive' installation method is used, duplicate service
  will be created. This can be avoided by updating pillar with
  'docker:pkg:docker:service:name: dockerd'. Due fact that 'archive'
  method is default this change may affect a large number of users

`1.1.2 <https://github.com/saltstack-formulas/docker-formula/compare/v1.1.1...v1.1.2>`_ (2021-03-10)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **osmap:** use CentOS settings as basis for Oracle & Amazon Linux (\ `28d40b3 <https://github.com/saltstack-formulas/docker-formula/commit/28d40b3082f8309f828aa60224c715024bbe53af>`_\ )

Code Refactoring
^^^^^^^^^^^^^^^^


* **map files:** cleanup and small fixes (\ `f839b06 <https://github.com/saltstack-formulas/docker-formula/commit/f839b0664c82c544359ec367a7379cf2d6085aa4>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **commitlint:** ensure ``upstream/master`` uses main repo URL [skip ci] (\ `648666d <https://github.com/saltstack-formulas/docker-formula/commit/648666d0590960f0f2a513c219ac7405bab62eb5>`_\ )
* **gemfile+lock:** use ``ssf`` customised ``kitchen-docker`` repo [skip ci] (\ `d88eac1 <https://github.com/saltstack-formulas/docker-formula/commit/d88eac16001c45c1c5314fc58ddf70fd7fadb73f>`_\ )
* **github/kitchen:** use GitHub Actions for Linux testing [skip ci] (\ `1febf87 <https://github.com/saltstack-formulas/docker-formula/commit/1febf87eb0b135914f7d0fac77381f52121cab28>`_\ )
* **gitlab-ci:** add ``rubocop`` linter (with ``allow_failure``\ ) [skip ci] (\ `a5b95c0 <https://github.com/saltstack-formulas/docker-formula/commit/a5b95c01377db3ab9f63210234ac19aa51043c88>`_\ )
* **kitchen+ci:** use latest pre-salted images (after CVE) [skip ci] (\ `2e15ae3 <https://github.com/saltstack-formulas/docker-formula/commit/2e15ae3eff47dd19b153dac440a323cbbacfd5d5>`_\ )
* **pre-commit:** update hook for ``rubocop`` [skip ci] (\ `8624eb0 <https://github.com/saltstack-formulas/docker-formula/commit/8624eb06f0847e64743b5e8cb398d0ac3ad930b1>`_\ )

`1.1.1 <https://github.com/saltstack-formulas/docker-formula/compare/v1.1.0...v1.1.1>`_ (2020-12-18)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **compose-ng:** add support for setting container devices (\ `2b04ee7 <https://github.com/saltstack-formulas/docker-formula/commit/2b04ee788e047a5283703199afea9e007f9d9c1e>`_\ )

`1.1.0 <https://github.com/saltstack-formulas/docker-formula/compare/v1.0.0...v1.1.0>`_ (2020-12-18)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **clean:** correct package name (\ `58efc33 <https://github.com/saltstack-formulas/docker-formula/commit/58efc33adb4f9ca0bee8b33b8c9ba7da6b787b40>`_\ )
* **repo:** correct typo and explicit null-check `#258 <https://github.com/saltstack-formulas/docker-formula/issues/258>`_ (\ `f5ec911 <https://github.com/saltstack-formulas/docker-formula/commit/f5ec91120eb1dbdc121c2b0faa54f0dfb81ecaea>`_\ )
* **typo:** refresh not refrsh (\ `f823af2 <https://github.com/saltstack-formulas/docker-formula/commit/f823af2ae91dd35237539bb953263e23a129a020>`_\ )
* **windows:** pip install docker (\ `b74bc08 <https://github.com/saltstack-formulas/docker-formula/commit/b74bc086864c1889de50da3d8a6376e104257ab2>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **gitlab-ci:** use GitLab CI as Travis CI replacement (\ `ab48dcd <https://github.com/saltstack-formulas/docker-formula/commit/ab48dcdf0a8943941e7cf2044fef099d6bc1b29b>`_\ )

Features
^^^^^^^^


* **arm64:** add support for Raspberry Pi 4 running Ubuntu 20.04 (\ `228ca07 <https://github.com/saltstack-formulas/docker-formula/commit/228ca0739711bdc280ed32a76e12501ccd4ea46b>`_\ )
* **proxy:** allow setting proxy in systemd (\ `ebeb2fe <https://github.com/saltstack-formulas/docker-formula/commit/ebeb2fe0332d91234f0bf78ae8b800ad694604b9>`_\ )

`1.0.0 <https://github.com/saltstack-formulas/docker-formula/compare/v0.44.0...v1.0.0>`_ (2020-11-18)
---------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **cent7:** install yum-plugin-versionlock too (\ `3b2e237 <https://github.com/saltstack-formulas/docker-formula/commit/3b2e2377a5f1160ca6dcfdf3bfca344f9d596b1f>`_\ )
* **clean:** do not remove python package (\ `e7ee880 <https://github.com/saltstack-formulas/docker-formula/commit/e7ee8809c94a56b06b7829b221a930c1bf5d7718>`_\ )
* **pillar.example:** fix ``yamllint`` violation [skip ci] (\ `31087af <https://github.com/saltstack-formulas/docker-formula/commit/31087afced764593b5758363d2e5b5f6382c68ea>`_\ ), closes `#250 <https://github.com/saltstack-formulas/docker-formula/issues/250>`_
* **state:** corrected remove state (\ `e178243 <https://github.com/saltstack-formulas/docker-formula/commit/e1782434e37778e365302c6c304bc357a54bd4b2>`_\ )

Code Refactoring
^^^^^^^^^^^^^^^^


* **rewrite:** modernize formula and fresh start (\ `1e48667 <https://github.com/saltstack-formulas/docker-formula/commit/1e48667188cbaac5497fcdb5c652f0a6dd3257ee>`_\ ), closes `#252 <https://github.com/saltstack-formulas/docker-formula/issues/252>`_ `#249 <https://github.com/saltstack-formulas/docker-formula/issues/249>`_ `#243 <https://github.com/saltstack-formulas/docker-formula/issues/243>`_ `#236 <https://github.com/saltstack-formulas/docker-formula/issues/236>`_ `#234 <https://github.com/saltstack-formulas/docker-formula/issues/234>`_ `#219 <https://github.com/saltstack-formulas/docker-formula/issues/219>`_ `#202 <https://github.com/saltstack-formulas/docker-formula/issues/202>`_ `#191 <https://github.com/saltstack-formulas/docker-formula/issues/191>`_ `#190 <https://github.com/saltstack-formulas/docker-formula/issues/190>`_ `#160 <https://github.com/saltstack-formulas/docker-formula/issues/160>`_ `#95 <https://github.com/saltstack-formulas/docker-formula/issues/95>`_ `#85 <https://github.com/saltstack-formulas/docker-formula/issues/85>`_ `#74 <https://github.com/saltstack-formulas/docker-formula/issues/74>`_ `#251 <https://github.com/saltstack-formulas/docker-formula/issues/251>`_ `#253 <https://github.com/saltstack-formulas/docker-formula/issues/253>`_

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** use ``saltimages`` Docker Hub where available [skip ci] (\ `1755f38 <https://github.com/saltstack-formulas/docker-formula/commit/1755f38fd9d8b895bfe8eac429fa62e48ed51697>`_\ )
* **pre-commit:** add to formula [skip ci] (\ `d04e24a <https://github.com/saltstack-formulas/docker-formula/commit/d04e24a6e8f819c5d808e6c30f8fac3356ad1d0b>`_\ )
* **pre-commit:** enable/disable ``rstcheck`` as relevant [skip ci] (\ `8454e4a <https://github.com/saltstack-formulas/docker-formula/commit/8454e4ad4476c8e7e6dd7af4197f787fb9d987ad>`_\ )
* **pre-commit:** finalise ``rstcheck`` configuration [skip ci] (\ `87c737c <https://github.com/saltstack-formulas/docker-formula/commit/87c737cb6fc2c7d7d4268f23f1fb074a580c653b>`_\ )
* **travis:** add notifications => zulip [skip ci] (\ `6222d60 <https://github.com/saltstack-formulas/docker-formula/commit/6222d60ad2883b89f901198947f5061e4a10ab43>`_\ )

Documentation
^^^^^^^^^^^^^


* **macos:** updated pillar.example & macos hash (\ `fc011b3 <https://github.com/saltstack-formulas/docker-formula/commit/fc011b38fa44e441586961cc7c051c008bfe66e5>`_\ )
* **readme:** fix macos clean state (\ `fca7fea <https://github.com/saltstack-formulas/docker-formula/commit/fca7fea55aba95e0f139128cde97ca2f5c133919>`_\ )

BREAKING CHANGES
^^^^^^^^^^^^^^^^


* 
  **rewrite:** This version is not backwards compatible. Update
  your states and pillar data to align with new formula.


  * MacOS was not tested in this PR but hopefully no regression.
  * docker.containers: sls was simplified (raise PR if regression)

`0.44.0 <https://github.com/saltstack-formulas/docker-formula/compare/v0.43.1...v0.44.0>`_ (2020-05-15)
-----------------------------------------------------------------------------------------------------------

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **gemfile.lock:** add to repo with updated ``Gemfile`` [skip ci] (\ `c3dd00a <https://github.com/saltstack-formulas/docker-formula/commit/c3dd00a2472eb092761419a88eeb0fa29117d97a>`_\ )
* **kitchen+travis:** remove ``master-py2-arch-base-latest`` [skip ci] (\ `df90212 <https://github.com/saltstack-formulas/docker-formula/commit/df9021232563c8fe4583c2faee48f8f1d17c3562>`_\ )
* **workflows/commitlint:** add to repo [skip ci] (\ `87a62cd <https://github.com/saltstack-formulas/docker-formula/commit/87a62cd8fb42b5561ad2ec12cfdba7b342f81359>`_\ )

Features
^^^^^^^^


* **compose-ng:** support working_dir, volume_driver, userns_mode & user (\ `30ec6ab <https://github.com/saltstack-formulas/docker-formula/commit/30ec6ab02bd0265e90b12bcc367b7334bf536a4a>`_\ )

`0.43.1 <https://github.com/saltstack-formulas/docker-formula/compare/v0.43.0...v0.43.1>`_ (2020-04-08)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **compose-ng:** fix ports, volumes, restart policy, add privileged mode (\ `f62a45c <https://github.com/saltstack-formulas/docker-formula/commit/f62a45cd0e1aea91eed27dac1724090ef18aceea>`_\ )
* avoid setting multiple pre-start stanzas in upstart (\ `80a2a98 <https://github.com/saltstack-formulas/docker-formula/commit/80a2a985e96b2d7c9867660f15a5e7a9808ee156>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** avoid using bootstrap for ``master`` instances [skip ci] (\ `27b509e <https://github.com/saltstack-formulas/docker-formula/commit/27b509e696e06b9ea244170608f348f841ebb36c>`_\ )

`0.43.0 <https://github.com/saltstack-formulas/docker-formula/compare/v0.42.0...v0.43.0>`_ (2020-01-22)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **release.config.js:** use full commit hash in commit link [skip ci] (\ `01ece3d <https://github.com/saltstack-formulas/docker-formula/commit/01ece3dba8e581b15da1087c58b484b56177f0de>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **gemfile:** restrict ``train`` gem version until upstream fix [skip ci] (\ `734d4e3 <https://github.com/saltstack-formulas/docker-formula/commit/734d4e3a884253ecc0f37493b0af6cf2398dbac0>`_\ )
* **kitchen:** use ``debian-10-master-py3`` instead of ``develop`` [skip ci] (\ `d87e787 <https://github.com/saltstack-formulas/docker-formula/commit/d87e7871989b56293b577976c122c6c7095d61e3>`_\ )
* **kitchen:** use ``develop`` image until ``master`` is ready (\ ``amazonlinux``\ ) [skip ci] (\ `71c5bcb <https://github.com/saltstack-formulas/docker-formula/commit/71c5bcb0aead53192ec4bb9f560ed312c80af1f6>`_\ )
* **kitchen+travis:** upgrade matrix after ``2019.2.2`` release [skip ci] (\ `2189efb <https://github.com/saltstack-formulas/docker-formula/commit/2189efbc8af5fa6a529acbe3410b62558132a044>`_\ )
* **travis:** apply changes from build config validation [skip ci] (\ `f0a07fc <https://github.com/saltstack-formulas/docker-formula/commit/f0a07fc7c03107b21dd9f7161972b084893f19ee>`_\ )
* **travis:** opt-in to ``dpl v2`` to complete build config validation [skip ci] (\ `340556e <https://github.com/saltstack-formulas/docker-formula/commit/340556e081780d890db064dc84d7fdd177e55d93>`_\ )
* **travis:** quote pathspecs used with ``git ls-files`` [skip ci] (\ `12bf914 <https://github.com/saltstack-formulas/docker-formula/commit/12bf914e2468ce8b09f172c12c5df8aa4b7175e5>`_\ )
* **travis:** run ``shellcheck`` during lint job [skip ci] (\ `ba127a0 <https://github.com/saltstack-formulas/docker-formula/commit/ba127a08113bf43f3bbb7691d1bc670e659e4c45>`_\ )
* **travis:** use ``major.minor`` for ``semantic-release`` version [skip ci] (\ `2590d61 <https://github.com/saltstack-formulas/docker-formula/commit/2590d61eeadb82ae420db450f3885b95a77be52c>`_\ )
* **travis:** use build config validation (beta) [skip ci] (\ `fe184e9 <https://github.com/saltstack-formulas/docker-formula/commit/fe184e95123ad90c2a38515a50118f5ab82cac1b>`_\ )

Features
^^^^^^^^


* support optional container removal before start in upstart/systemd (\ `cc10d97 <https://github.com/saltstack-formulas/docker-formula/commit/cc10d97ee0a8f85f8d94f6ec4b1918c906338afd>`_\ )

Performance Improvements
^^^^^^^^^^^^^^^^^^^^^^^^


* **travis:** improve ``salt-lint`` invocation [skip ci] (\ `18fa798 <https://github.com/saltstack-formulas/docker-formula/commit/18fa79879dbb37c90c45c836018126dfbd61f5e2>`_\ )

`0.42.0 <https://github.com/saltstack-formulas/docker-formula/compare/v0.41.0...v0.42.0>`_ (2019-10-23)
-----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **compose-ng.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/docker-formula/commit/9e8e1e8>`_\ )
* **pillar.example:** ensure ``docker.config`` is available (\ ` <https://github.com/saltstack-formulas/docker-formula/commit/dce112a>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **travis:** update ``salt-lint`` config for ``v0.0.10`` (\ ` <https://github.com/saltstack-formulas/docker-formula/commit/3eaed1b>`_\ )

Documentation
^^^^^^^^^^^^^


* **readme:** move to ``docs/`` directory and modify accordingly (\ ` <https://github.com/saltstack-formulas/docker-formula/commit/222fc6d>`_\ )

Features
^^^^^^^^


* **semantic-release:** implement for this formula (\ ` <https://github.com/saltstack-formulas/docker-formula/commit/ea6be11>`_\ )

Tests
^^^^^


* **inspec:** add tests for package, config & service (\ ` <https://github.com/saltstack-formulas/docker-formula/commit/451d76d>`_\ )
* **testinfra:** remove from the formula (\ ` <https://github.com/saltstack-formulas/docker-formula/commit/62122d2>`_\ )
