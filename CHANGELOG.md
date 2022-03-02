# Changelog

## [2.4.2](https://github.com/saltstack-formulas/docker-formula/compare/v2.4.1...v2.4.2) (2022-03-02)


### Bug Fixes

* **debian:** avoid adding repositories entries multiple times ([31ab3af](https://github.com/saltstack-formulas/docker-formula/commit/31ab3afafca23b6cdfcef28b72f309117fdf2e76)), closes [/github.com/saltstack/salt/issues/59785#issuecomment-826590482](https://github.com//github.com/saltstack/salt/issues/59785/issues/issuecomment-826590482)

## [2.4.1](https://github.com/saltstack-formulas/docker-formula/compare/v2.4.0...v2.4.1) (2022-03-02)


### Bug Fixes

* **osfamilymap:** use correct OS arch for deb pkg ([62eae20](https://github.com/saltstack-formulas/docker-formula/commit/62eae20c9b0e4c6cc393cf9b7d5d25e92701657b))


### Continuous Integration

* update linters to latest versions [skip ci] ([6fc940b](https://github.com/saltstack-formulas/docker-formula/commit/6fc940bb5b0f4e3f6aa4ff3c50f50bd81a777255))


### Tests

* **repository:** fix `rubocop` violation [skip ci] ([bf38410](https://github.com/saltstack-formulas/docker-formula/commit/bf38410cfc5d5aa667fcb6fb56c930473f8372bd))
* **repository:** use `system.platform[:codename]` [skip ci] ([a13ec28](https://github.com/saltstack-formulas/docker-formula/commit/a13ec287b87dd8e0bb0ef4dd74ea4cd613619331))
* **system:** add `build_platform_codename` [skip ci] ([80c4591](https://github.com/saltstack-formulas/docker-formula/commit/80c4591a969b57adb0cf190958b9e9b92b2a043e))

# [2.4.0](https://github.com/saltstack-formulas/docker-formula/compare/v2.3.1...v2.4.0) (2022-02-10)


### Bug Fixes

* **centos:** modify repository url ([55ff30a](https://github.com/saltstack-formulas/docker-formula/commit/55ff30afb13abdb578dd37435f5c37b9670de748))
* **debian:** remove repository using `file` instead of `pkgrepo` ([28ea2f9](https://github.com/saltstack-formulas/docker-formula/commit/28ea2f92e05f95123467ec0f29e3a79ff944c731))
* **dependencies:** add needed packages for Redhat's family members ([652da44](https://github.com/saltstack-formulas/docker-formula/commit/652da448311d2935e3695e8ca5a0084c10fae38d))
* **repository:** amazonlinux repository url ([949551b](https://github.com/saltstack-formulas/docker-formula/commit/949551b46306297f7be2064ebd87c65b5df5c155))


### Continuous Integration

* **gemfile:** allow rubygems proxy to be provided as an env var [skip ci] ([a1a5880](https://github.com/saltstack-formulas/docker-formula/commit/a1a58804f560eb5a82c7b2c626f9b8d3f6b3d1a2))
* **kitchen+ci:** update with `3004` pre-salted images/boxes [skip ci] ([caf640a](https://github.com/saltstack-formulas/docker-formula/commit/caf640ac724ef30f2b1b2d161bc3584db404e542))
* **kitchen+ci:** update with latest CVE pre-salted images [skip ci] ([141ae5e](https://github.com/saltstack-formulas/docker-formula/commit/141ae5e15dfe2acea1fd727593610fb39c1ddc60))
* **kitchen+gitlab:** update for new pre-salted images [skip ci] ([e19468b](https://github.com/saltstack-formulas/docker-formula/commit/e19468bc16e81431da398a84e91d635554defdb8))


### Features

* **debian:** use repository keyring instead of key_id ([db49eba](https://github.com/saltstack-formulas/docker-formula/commit/db49ebaaacc09da13fbbde3fe1303957d157170f))


### Tests

* **repository:** redhat's family alternatives for repo url ([410078c](https://github.com/saltstack-formulas/docker-formula/commit/410078c5f47da3dd52a45705175e719448cfb0a2))

## [2.3.1](https://github.com/saltstack-formulas/docker-formula/compare/v2.3.0...v2.3.1) (2021-09-09)


### Bug Fixes

* **windows:** pip install as user ([#306](https://github.com/saltstack-formulas/docker-formula/issues/306)) ([df35704](https://github.com/saltstack-formulas/docker-formula/commit/df35704ebf6f7906146eb6c4c9773ea9bed52259))

# [2.3.0](https://github.com/saltstack-formulas/docker-formula/compare/v2.2.0...v2.3.0) (2021-09-08)


### Features

* **ng:** improve ng.clean state and ci ([#300](https://github.com/saltstack-formulas/docker-formula/issues/300)) ([92883e2](https://github.com/saltstack-formulas/docker-formula/commit/92883e288cb9d0d76695e6f3867a2f6e3d5bef74))

# [2.2.0](https://github.com/saltstack-formulas/docker-formula/compare/v2.1.1...v2.2.0) (2021-09-08)


### Bug Fixes

* **coupling:** allow docker install without compose ([#298](https://github.com/saltstack-formulas/docker-formula/issues/298)) ([aaedb00](https://github.com/saltstack-formulas/docker-formula/commit/aaedb001f17e02ee44fb0609d04dda5d1c395916))
* **environ:** remove superfluous config dict ([#301](https://github.com/saltstack-formulas/docker-formula/issues/301)) ([67ba2af](https://github.com/saltstack-formulas/docker-formula/commit/67ba2af44e2ff76b2e498c8f53cdf2410da458c1))
* **windows:** change id to whoami ([#299](https://github.com/saltstack-formulas/docker-formula/issues/299)) ([c0780ad](https://github.com/saltstack-formulas/docker-formula/commit/c0780adcacf629bd639a248fb135c7be8b94ddb5))


### Features

* **limitnofile:** add support to systemd ([#302](https://github.com/saltstack-formulas/docker-formula/issues/302)) ([299a1d0](https://github.com/saltstack-formulas/docker-formula/commit/299a1d087a96515fcf35739163e52330f4d7b297))

## [2.1.1](https://github.com/saltstack-formulas/docker-formula/compare/v2.1.0...v2.1.1) (2021-09-07)


### Code Refactoring

* **jinja2:** remove excessive jinja, not useful pattern ([#303](https://github.com/saltstack-formulas/docker-formula/issues/303)) ([a79f8d3](https://github.com/saltstack-formulas/docker-formula/commit/a79f8d31cb2439bdf8ce0ef9f37b5913d392faa6))

# [2.1.0](https://github.com/saltstack-formulas/docker-formula/compare/v2.0.7...v2.1.0) (2021-09-04)


### Bug Fixes

* raspbian pi4 dockerd failing with segmentation fault, issue [#286](https://github.com/saltstack-formulas/docker-formula/issues/286) ([#287](https://github.com/saltstack-formulas/docker-formula/issues/287)) ([85fb5d4](https://github.com/saltstack-formulas/docker-formula/commit/85fb5d4dedb59bcc367967dff7495f24ab0ddd23))


### Continuous Integration

* **3003.1:** update inc. AlmaLinux, Rocky & `rst-lint` [skip ci] ([4d373a1](https://github.com/saltstack-formulas/docker-formula/commit/4d373a1167e5a935e22dca5e4e55f954c6fcaaae))
* **gemfile+lock:** use `ssf` customised `inspec` repo [skip ci] ([16cc758](https://github.com/saltstack-formulas/docker-formula/commit/16cc7581e3dd2552aa3ab1cf82c9492bae5582b3))
* **kitchen:** move `provisioner` block & update `run_command` [skip ci] ([4ea5f26](https://github.com/saltstack-formulas/docker-formula/commit/4ea5f26104a1649b61036dd2550c91764f017f65))
* **kitchen+ci:** update with latest `3003.2` pre-salted images [skip ci] ([4fc33ad](https://github.com/saltstack-formulas/docker-formula/commit/4fc33ada834a28cd3fc714a9fc75fffe46173143))
* add Debian 11 Bullseye & update `yamllint` configuration [skip ci] ([1e822d0](https://github.com/saltstack-formulas/docker-formula/commit/1e822d0855a1d46326fc5fa2559b302a18f6969c))
* **kitchen+gitlab:** remove Ubuntu 16.04 & Fedora 32 (EOL) [skip ci] ([0615c75](https://github.com/saltstack-formulas/docker-formula/commit/0615c75ffc2debaca35b3901d1a9a2a17a74aee8))


### Features

* **alma+rocky:** add platforms (based on CentOS 8) [skip ci] ([39fc09a](https://github.com/saltstack-formulas/docker-formula/commit/39fc09a89d4389b1f93cff1d83a9b2d66038e6c0))

## [2.0.7](https://github.com/saltstack-formulas/docker-formula/compare/v2.0.6...v2.0.7) (2021-06-02)


### Bug Fixes

* **clean:** fix syntax error in networks.clean ([89cd4fc](https://github.com/saltstack-formulas/docker-formula/commit/89cd4fccf0109fb37a33a4de762b6a2c5c02bbc2))

## [2.0.6](https://github.com/saltstack-formulas/docker-formula/compare/v2.0.5...v2.0.6) (2021-05-21)


### Bug Fixes

* **service:** reload the docker service when daemon.json has changed ([b34f434](https://github.com/saltstack-formulas/docker-formula/commit/b34f434a5ae35ee1fb54b7c542a59d5ba4ab32da))

## [2.0.5](https://github.com/saltstack-formulas/docker-formula/compare/v2.0.4...v2.0.5) (2021-05-20)


### Bug Fixes

* **clean:** fix clean of repo for the RedHat family ([4730a72](https://github.com/saltstack-formulas/docker-formula/commit/4730a725c773430674199be99fb8fffe65febfdf))
* **clean:** fix syntax error in networks.clean state file ([53db7ad](https://github.com/saltstack-formulas/docker-formula/commit/53db7ad8ef775f725b5c339402473d15075174bc))
* **clean:** fix syntax error with use_upstream repo ([428dccd](https://github.com/saltstack-formulas/docker-formula/commit/428dccdf15c119c32847db0374ff71152157c8a9))
* **clean:** make repo install and clean states consistent ([af16bb7](https://github.com/saltstack-formulas/docker-formula/commit/af16bb7781da5653c50375c8e197591a2b7d7c09))
* **clean:** remove invalid 'onlyif' statement from repo.clean ([b3c56cb](https://github.com/saltstack-formulas/docker-formula/commit/b3c56cb9e1784d217eb4cba71caf2a75b0c3a0d4))
* **clean:** update condition that enables the repo ([1f5190b](https://github.com/saltstack-formulas/docker-formula/commit/1f5190b20c77cfc5be0e9150cce09b46917f7fdd))
* **clean:** update enable_repo condition to be more robust ([a7f382f](https://github.com/saltstack-formulas/docker-formula/commit/a7f382f3f511b7006f0980efae3db7164ae2a95d))
* **test:** add missing tests to verify installation from repo ([5a62de9](https://github.com/saltstack-formulas/docker-formula/commit/5a62de91f8afeed3656d939951739c6da3907b9d))


### Continuous Integration

* **kitchen:** use `master` as default instance for Arch Linux [skip ci] ([161d8cc](https://github.com/saltstack-formulas/docker-formula/commit/161d8cc691eb3dd389cdbce4f3cd54013c3093ed))

## [2.0.4](https://github.com/saltstack-formulas/docker-formula/compare/v2.0.3...v2.0.4) (2021-05-19)


### Bug Fixes

* **config:** replace URLs to bintray.com by github.com ([2f60c21](https://github.com/saltstack-formulas/docker-formula/commit/2f60c21fc26dd790c4cb032671a59b477d0197e1))
* **config:** use 'latest' docker-compose versions from github ([d434e25](https://github.com/saltstack-formulas/docker-formula/commit/d434e2570dbf775b34e2c98d835f9c0378709a63))


### Continuous Integration

* add `arch-master` to matrix and update `.travis.yml` [skip ci] ([cec557a](https://github.com/saltstack-formulas/docker-formula/commit/cec557abc7dc77a5227852c216047855ab726c57))


### Documentation

* remove files which aren't formula-specific [skip ci] ([4cc1e70](https://github.com/saltstack-formulas/docker-formula/commit/4cc1e706e4778e1aabef0023da668eaafef8afff))
* **readme:** fix headings and links [skip ci] ([b0021eb](https://github.com/saltstack-formulas/docker-formula/commit/b0021eb3a379fe8db7bed584fb6ae5d1f060a581))

## [2.0.3](https://github.com/saltstack-formulas/docker-formula/compare/v2.0.2...v2.0.3) (2021-04-23)


### Bug Fixes

* **config:** remove daemon.json in clean states ([6967a98](https://github.com/saltstack-formulas/docker-formula/commit/6967a98eb5219370996b6091f81eace56870174a))


### Continuous Integration

* **kitchen+gitlab:** adjust matrix to add `3003` [skip ci] ([2c7fe1a](https://github.com/saltstack-formulas/docker-formula/commit/2c7fe1ad322667664eb38782bd95a311c3c387cf))

## [2.0.2](https://github.com/saltstack-formulas/docker-formula/compare/v2.0.1...v2.0.2) (2021-04-22)


### Bug Fixes

* **config:** remove block comment from daemon file ([d075a0f](https://github.com/saltstack-formulas/docker-formula/commit/d075a0f926f5f17bee3932f4fe48f9b4627ad899))

## [2.0.1](https://github.com/saltstack-formulas/docker-formula/compare/v2.0.0...v2.0.1) (2021-04-21)


### Bug Fixes

* **config:** remove empty daemon.json ([3631fdb](https://github.com/saltstack-formulas/docker-formula/commit/3631fdb2cc6ed50d26f6ffd9cb9bccf31edaf5d5))
* **config:** revert previous changes in file.sls ([1cdfb57](https://github.com/saltstack-formulas/docker-formula/commit/1cdfb57b6bbbc2f13c1877b71fcd18fc1274518b))
* **config:** write config dictionary to daemon.json ([0e6febc](https://github.com/saltstack-formulas/docker-formula/commit/0e6febc5f104f5d6de232bf0d49226b53c1a8644))
* **config:** write config dictionary to daemon.json ([413cf58](https://github.com/saltstack-formulas/docker-formula/commit/413cf58b4f283af4d3a3aa8595e21fd56828d310))
* **config:** write daemon_config dictionary to daemon.json ([4af9866](https://github.com/saltstack-formulas/docker-formula/commit/4af9866f04632a0bcad8ce930ef85f219559693f))
* **config:** write daemon_config dictionary to daemon.json ([ea2505b](https://github.com/saltstack-formulas/docker-formula/commit/ea2505b98871c1da8f7fff1a801157d1cee14ac5))
* **python-docker:** install with pip ([7d73e8a](https://github.com/saltstack-formulas/docker-formula/commit/7d73e8aca45e2e1e95ace6add1f665271519840c))

# [2.0.0](https://github.com/saltstack-formulas/docker-formula/compare/v1.1.2...v2.0.0) (2021-04-16)


### Bug Fixes

* **service:** change default service name ([f8f96f1](https://github.com/saltstack-formulas/docker-formula/commit/f8f96f1fab80e9edb6e2e86d4df310dc312bf9bb))


### Tests

* standardise use of `share` suite & `_mapdata` state [skip ci] ([69d7e65](https://github.com/saltstack-formulas/docker-formula/commit/69d7e65e9f5b6982e758ab0e04d177b16ebd2d7c))
* **service:** enable for `archive` and `package` suites ([c168ee1](https://github.com/saltstack-formulas/docker-formula/commit/c168ee110e80c993869ec38cab6a16782ea60fef))


### BREAKING CHANGES

* **service:** due changes in default service name, on systems
where 'archive' installation method is used, duplicate service
will be created. This can be avoided by updating pillar with
'docker:pkg:docker:service:name: dockerd'. Due fact that 'archive'
method is default this change may affect a large number of users

## [1.1.2](https://github.com/saltstack-formulas/docker-formula/compare/v1.1.1...v1.1.2) (2021-03-10)


### Bug Fixes

* **osmap:** use CentOS settings as basis for Oracle & Amazon Linux ([28d40b3](https://github.com/saltstack-formulas/docker-formula/commit/28d40b3082f8309f828aa60224c715024bbe53af))


### Code Refactoring

* **map files:** cleanup and small fixes ([f839b06](https://github.com/saltstack-formulas/docker-formula/commit/f839b0664c82c544359ec367a7379cf2d6085aa4))


### Continuous Integration

* **commitlint:** ensure `upstream/master` uses main repo URL [skip ci] ([648666d](https://github.com/saltstack-formulas/docker-formula/commit/648666d0590960f0f2a513c219ac7405bab62eb5))
* **gemfile+lock:** use `ssf` customised `kitchen-docker` repo [skip ci] ([d88eac1](https://github.com/saltstack-formulas/docker-formula/commit/d88eac16001c45c1c5314fc58ddf70fd7fadb73f))
* **github/kitchen:** use GitHub Actions for Linux testing [skip ci] ([1febf87](https://github.com/saltstack-formulas/docker-formula/commit/1febf87eb0b135914f7d0fac77381f52121cab28))
* **gitlab-ci:** add `rubocop` linter (with `allow_failure`) [skip ci] ([a5b95c0](https://github.com/saltstack-formulas/docker-formula/commit/a5b95c01377db3ab9f63210234ac19aa51043c88))
* **kitchen+ci:** use latest pre-salted images (after CVE) [skip ci] ([2e15ae3](https://github.com/saltstack-formulas/docker-formula/commit/2e15ae3eff47dd19b153dac440a323cbbacfd5d5))
* **pre-commit:** update hook for `rubocop` [skip ci] ([8624eb0](https://github.com/saltstack-formulas/docker-formula/commit/8624eb06f0847e64743b5e8cb398d0ac3ad930b1))

## [1.1.1](https://github.com/saltstack-formulas/docker-formula/compare/v1.1.0...v1.1.1) (2020-12-18)


### Bug Fixes

* **compose-ng:** add support for setting container devices ([2b04ee7](https://github.com/saltstack-formulas/docker-formula/commit/2b04ee788e047a5283703199afea9e007f9d9c1e))

# [1.1.0](https://github.com/saltstack-formulas/docker-formula/compare/v1.0.0...v1.1.0) (2020-12-18)


### Bug Fixes

* **clean:** correct package name ([58efc33](https://github.com/saltstack-formulas/docker-formula/commit/58efc33adb4f9ca0bee8b33b8c9ba7da6b787b40))
* **repo:** correct typo and explicit null-check [#258](https://github.com/saltstack-formulas/docker-formula/issues/258) ([f5ec911](https://github.com/saltstack-formulas/docker-formula/commit/f5ec91120eb1dbdc121c2b0faa54f0dfb81ecaea))
* **typo:** refresh not refrsh ([f823af2](https://github.com/saltstack-formulas/docker-formula/commit/f823af2ae91dd35237539bb953263e23a129a020))
* **windows:** pip install docker ([b74bc08](https://github.com/saltstack-formulas/docker-formula/commit/b74bc086864c1889de50da3d8a6376e104257ab2))


### Continuous Integration

* **gitlab-ci:** use GitLab CI as Travis CI replacement ([ab48dcd](https://github.com/saltstack-formulas/docker-formula/commit/ab48dcdf0a8943941e7cf2044fef099d6bc1b29b))


### Features

* **arm64:** add support for Raspberry Pi 4 running Ubuntu 20.04 ([228ca07](https://github.com/saltstack-formulas/docker-formula/commit/228ca0739711bdc280ed32a76e12501ccd4ea46b))
* **proxy:** allow setting proxy in systemd ([ebeb2fe](https://github.com/saltstack-formulas/docker-formula/commit/ebeb2fe0332d91234f0bf78ae8b800ad694604b9))

# [1.0.0](https://github.com/saltstack-formulas/docker-formula/compare/v0.44.0...v1.0.0) (2020-11-18)


### Bug Fixes

* **cent7:** install yum-plugin-versionlock too ([3b2e237](https://github.com/saltstack-formulas/docker-formula/commit/3b2e2377a5f1160ca6dcfdf3bfca344f9d596b1f))
* **clean:** do not remove python package ([e7ee880](https://github.com/saltstack-formulas/docker-formula/commit/e7ee8809c94a56b06b7829b221a930c1bf5d7718))
* **pillar.example:** fix `yamllint` violation [skip ci] ([31087af](https://github.com/saltstack-formulas/docker-formula/commit/31087afced764593b5758363d2e5b5f6382c68ea)), closes [#250](https://github.com/saltstack-formulas/docker-formula/issues/250)
* **state:** corrected remove state ([e178243](https://github.com/saltstack-formulas/docker-formula/commit/e1782434e37778e365302c6c304bc357a54bd4b2))


### Code Refactoring

* **rewrite:** modernize formula and fresh start ([1e48667](https://github.com/saltstack-formulas/docker-formula/commit/1e48667188cbaac5497fcdb5c652f0a6dd3257ee)), closes [#252](https://github.com/saltstack-formulas/docker-formula/issues/252) [#249](https://github.com/saltstack-formulas/docker-formula/issues/249) [#243](https://github.com/saltstack-formulas/docker-formula/issues/243) [#236](https://github.com/saltstack-formulas/docker-formula/issues/236) [#234](https://github.com/saltstack-formulas/docker-formula/issues/234) [#219](https://github.com/saltstack-formulas/docker-formula/issues/219) [#202](https://github.com/saltstack-formulas/docker-formula/issues/202) [#191](https://github.com/saltstack-formulas/docker-formula/issues/191) [#190](https://github.com/saltstack-formulas/docker-formula/issues/190) [#160](https://github.com/saltstack-formulas/docker-formula/issues/160) [#95](https://github.com/saltstack-formulas/docker-formula/issues/95) [#85](https://github.com/saltstack-formulas/docker-formula/issues/85) [#74](https://github.com/saltstack-formulas/docker-formula/issues/74) [#251](https://github.com/saltstack-formulas/docker-formula/issues/251) [#253](https://github.com/saltstack-formulas/docker-formula/issues/253)


### Continuous Integration

* **kitchen:** use `saltimages` Docker Hub where available [skip ci] ([1755f38](https://github.com/saltstack-formulas/docker-formula/commit/1755f38fd9d8b895bfe8eac429fa62e48ed51697))
* **pre-commit:** add to formula [skip ci] ([d04e24a](https://github.com/saltstack-formulas/docker-formula/commit/d04e24a6e8f819c5d808e6c30f8fac3356ad1d0b))
* **pre-commit:** enable/disable `rstcheck` as relevant [skip ci] ([8454e4a](https://github.com/saltstack-formulas/docker-formula/commit/8454e4ad4476c8e7e6dd7af4197f787fb9d987ad))
* **pre-commit:** finalise `rstcheck` configuration [skip ci] ([87c737c](https://github.com/saltstack-formulas/docker-formula/commit/87c737cb6fc2c7d7d4268f23f1fb074a580c653b))
* **travis:** add notifications => zulip [skip ci] ([6222d60](https://github.com/saltstack-formulas/docker-formula/commit/6222d60ad2883b89f901198947f5061e4a10ab43))


### Documentation

* **macos:** updated pillar.example & macos hash ([fc011b3](https://github.com/saltstack-formulas/docker-formula/commit/fc011b38fa44e441586961cc7c051c008bfe66e5))
* **readme:** fix macos clean state ([fca7fea](https://github.com/saltstack-formulas/docker-formula/commit/fca7fea55aba95e0f139128cde97ca2f5c133919))


### BREAKING CHANGES

* **rewrite:** This version is not backwards compatible. Update
 your states and pillar data to align with new formula.

 - MacOS was not tested in this PR but hopefully no regression.
 - docker.containers: sls was simplified (raise PR if regression)

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
