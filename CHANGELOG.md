# Changelog

# [0.44.0](https://github.com/saltstack-formulas/docker-formula/compare/v0.43.1...v0.44.0) (2020-05-15)


### Continuous Integration

* **gemfile.lock:** add to repo with updated `Gemfile` [skip ci] ([c3dd00a](https://github.com/saltstack-formulas/docker-formula/commit/c3dd00a2472eb092761419a88eeb0fa29117d97a))
* **kitchen+travis:** remove `master-py2-arch-base-latest` [skip ci] ([df90212](https://github.com/saltstack-formulas/docker-formula/commit/df9021232563c8fe4583c2faee48f8f1d17c3562))
* **workflows/commitlint:** add to repo [skip ci] ([87a62cd](https://github.com/saltstack-formulas/docker-formula/commit/87a62cd8fb42b5561ad2ec12cfdba7b342f81359))


### Features

* **compose-ng:** support working_dir, volume_driver, userns_mode & user ([30ec6ab](https://github.com/saltstack-formulas/docker-formula/commit/30ec6ab02bd0265e90b12bcc367b7334bf536a4a))

## [0.43.1](https://github.com/saltstack-formulas/docker-formula/compare/v0.43.0...v0.43.1) (2020-04-08)


### Bug Fixes

* **compose-ng:** fix ports, volumes, restart policy, add privileged mode ([f62a45c](https://github.com/saltstack-formulas/docker-formula/commit/f62a45cd0e1aea91eed27dac1724090ef18aceea))
* avoid setting multiple pre-start stanzas in upstart ([80a2a98](https://github.com/saltstack-formulas/docker-formula/commit/80a2a985e96b2d7c9867660f15a5e7a9808ee156))


### Continuous Integration

* **kitchen:** avoid using bootstrap for `master` instances [skip ci] ([27b509e](https://github.com/saltstack-formulas/docker-formula/commit/27b509e696e06b9ea244170608f348f841ebb36c))

# [0.43.0](https://github.com/saltstack-formulas/docker-formula/compare/v0.42.0...v0.43.0) (2020-01-22)


### Bug Fixes

* **release.config.js:** use full commit hash in commit link [skip ci] ([01ece3d](https://github.com/saltstack-formulas/docker-formula/commit/01ece3dba8e581b15da1087c58b484b56177f0de))


### Continuous Integration

* **gemfile:** restrict `train` gem version until upstream fix [skip ci] ([734d4e3](https://github.com/saltstack-formulas/docker-formula/commit/734d4e3a884253ecc0f37493b0af6cf2398dbac0))
* **kitchen:** use `debian-10-master-py3` instead of `develop` [skip ci] ([d87e787](https://github.com/saltstack-formulas/docker-formula/commit/d87e7871989b56293b577976c122c6c7095d61e3))
* **kitchen:** use `develop` image until `master` is ready (`amazonlinux`) [skip ci] ([71c5bcb](https://github.com/saltstack-formulas/docker-formula/commit/71c5bcb0aead53192ec4bb9f560ed312c80af1f6))
* **kitchen+travis:** upgrade matrix after `2019.2.2` release [skip ci] ([2189efb](https://github.com/saltstack-formulas/docker-formula/commit/2189efbc8af5fa6a529acbe3410b62558132a044))
* **travis:** apply changes from build config validation [skip ci] ([f0a07fc](https://github.com/saltstack-formulas/docker-formula/commit/f0a07fc7c03107b21dd9f7161972b084893f19ee))
* **travis:** opt-in to `dpl v2` to complete build config validation [skip ci] ([340556e](https://github.com/saltstack-formulas/docker-formula/commit/340556e081780d890db064dc84d7fdd177e55d93))
* **travis:** quote pathspecs used with `git ls-files` [skip ci] ([12bf914](https://github.com/saltstack-formulas/docker-formula/commit/12bf914e2468ce8b09f172c12c5df8aa4b7175e5))
* **travis:** run `shellcheck` during lint job [skip ci] ([ba127a0](https://github.com/saltstack-formulas/docker-formula/commit/ba127a08113bf43f3bbb7691d1bc670e659e4c45))
* **travis:** use `major.minor` for `semantic-release` version [skip ci] ([2590d61](https://github.com/saltstack-formulas/docker-formula/commit/2590d61eeadb82ae420db450f3885b95a77be52c))
* **travis:** use build config validation (beta) [skip ci] ([fe184e9](https://github.com/saltstack-formulas/docker-formula/commit/fe184e95123ad90c2a38515a50118f5ab82cac1b))


### Features

* support optional container removal before start in upstart/systemd ([cc10d97](https://github.com/saltstack-formulas/docker-formula/commit/cc10d97ee0a8f85f8d94f6ec4b1918c906338afd))


### Performance Improvements

* **travis:** improve `salt-lint` invocation [skip ci] ([18fa798](https://github.com/saltstack-formulas/docker-formula/commit/18fa79879dbb37c90c45c836018126dfbd61f5e2))

# [0.42.0](https://github.com/saltstack-formulas/docker-formula/compare/v0.41.0...v0.42.0) (2019-10-23)


### Bug Fixes

* **compose-ng.sls:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/docker-formula/commit/9e8e1e8))
* **pillar.example:** ensure `docker.config` is available ([](https://github.com/saltstack-formulas/docker-formula/commit/dce112a))


### Continuous Integration

* **travis:** update `salt-lint` config for `v0.0.10` ([](https://github.com/saltstack-formulas/docker-formula/commit/3eaed1b))


### Documentation

* **readme:** move to `docs/` directory and modify accordingly ([](https://github.com/saltstack-formulas/docker-formula/commit/222fc6d))


### Features

* **semantic-release:** implement for this formula ([](https://github.com/saltstack-formulas/docker-formula/commit/ea6be11))


### Tests

* **inspec:** add tests for package, config & service ([](https://github.com/saltstack-formulas/docker-formula/commit/451d76d))
* **testinfra:** remove from the formula ([](https://github.com/saltstack-formulas/docker-formula/commit/62122d2))
