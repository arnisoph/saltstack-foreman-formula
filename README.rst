=========================
saltstack-foreman-formula
=========================


.. image:: https://img.shields.io/badge/flattr-donate-red.svg
    :alt: Donate via flattr
    :target: https://flattr.com/profile/bechtoldt

.. image:: https://img.shields.io/gratipay/bechtoldt.svg
    :alt: Donate via Gratipay
    :target: https://www.gratipay.com/bechtoldt/

.. image:: https://img.shields.io/badge/license-Apache--2.0-blue.svg
    :alt: Apache-2.0-licensed
    :target: https://github.com/bechtoldt/saltstack-foreman-formula/blob/master/LICENSE

.. image:: https://img.shields.io/badge/gitter-chat-brightgreen.svg
    :alt: Join Chat
    :target: https://gitter.im/bechtoldt/saltstack-foreman-formula?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge

SaltStack Formula to set up and configure the lifecycle management tool Foreman

.. contents::
    :backlinks: none
    :local:


Instructions
------------

Please refer to https://github.com/bechtoldt/formula-docs to learn how to use
this formula, how it is built and how you can add your changes.


**NOTICE:** This formula might uses the formhelper module which is a very useful Salt execution module that isn't available in upstream yet. Please consider retrieving it manually from https://github.com/bechtoldt/salt-modules and make it available to your Salt installation. Read `SaltStack documentation <http://docs.saltstack.com/en/latest/ref/modules/#modules-are-easy-to-write>`_ to see how this can be achieved.

Take a look at older releases (branches) to get a version that isn't using the formhelper yet (if any).



Contributing
------------

Contributions are welcome! All development guidelines we ask you to follow can
be found at https://github.com/bechtoldt/formula-docs.

In general:

1. Fork this repo on Github
2. Add changes, test them, update docs (README.rst) if possible
3. Submit your pull request (PR) on Github, wait for feedback

But it’s better to `file an issue <https://github.com/bechtoldt/saltstack-foreman-formula/issues/new>`_ with your idea first.


TODO
----

* add instructions how to use formhelper, add information about it in the formula-docs (dependency), show up alternative?
* table/ matrix: os/salt compatibility (dedicated file)
* add list of available states
* add tests
* do initial Foreman setup (domains, proxies, OSs, etc.) with hammer CLI (WIP)
* show full example/ demonstration/ screencast of how to use this and other formulas
* plugins require internet access, configure http(s) proxy env var?
* add EL support


Authors
-------

* Arnold Bechtoldt <mail@arnoldbechtoldt.com>


Miscellaneous
-------------

Recommended formulas:

* Bind DNS utilities: `binddns-formula <https://github.com/bechtoldt/binddns-formula>`_
* ISC dhcp server: `iscdhcp-formula <https://github.com/bechtoldt/iscdhcp-formula>`_
* host network management: `network-formula <https://github.com/bechtoldt/network-formula>`_
* tftp setup: `tftp-formula <https://github.com/bechtoldt/tftp-formula>`_
* libvirt mgmt: `libvirt-formula <https://github.com/bechtoldt/libvirt-formula>`_
* PostgreSQL DB: `postgresql-formula <https://github.com/bechtoldt/postgresql-formula>`_
* Apache httpd: `httpd-formula <https://github.com/bechtoldt/httpd-formula>`_

Further reading:

* Documentation and Standardisation of SaltStack formulas: https://github.com/bechtoldt/formula-docs
