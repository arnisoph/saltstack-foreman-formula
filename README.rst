===============
foreman-formula
===============

Salt Stack Formula to set up and configure the lifecycle management tool Foreman

NOTICE BEFORE YOU USE
=====================

* This formula aims to follow the conventions and recommendations described at http://docs.saltstack.com/topics/conventions/formulas.html

TODO
====

The long-term goal is to have a comfortable formula and all Puppet modules used by the foreman-installer (kafo) to be replaced by Salt Stack Formulas.

* get Foreman free from Puppet (nearly done)
* install Foreman itself
* do initial Foreman setup (domains, proxies, OSs, etc.) with hammer CLI (WIP)
* general: implement concept of executing the formulas in the correct order
* ssl certs
* show full example/ demonstration/ screencast of how to use this and other formulas

Instructions
============

1. Add this repository as a `GitFS <http://docs.saltstack.com/topics/tutorials/gitfs.html>`_ backend in your Salt master config.

2. Configure your Pillar top file (``/srv/pillar/top.sls``), see pillar.example

3. Include this Formula within another Formula or simply define your needed states within the Salt top file (``/srv/salt/top.sls``).

Available states
================

.. contents::
    :local:

``foreman``
-----------

Installs the Foreman repo

``foreman.cli``
-------------------

Install Foreman CLI tools (hammer-cli)

``foreman.compute``
-------------------

Manage Foreman compute resources

``foreman.compute.libvirt``
---------------------------

Manage Foreman libvirt compute resources

``foreman.console``
-------------------

Manage Foreman console feature

``foreman.installer``
---------------------

Manage/ Install Foreman via foreman-installer (kafo/puppet based)

``foreman.plugins``
-------------------

Manage (install) plugins

``foreman.proxy``
-----------------

Manage Foreman proxy


Additional resources
====================

See http://theforeman.org/manuals/1.4/index.html#3.2ForemanInstaller

You may want to use the following formulas too:

* `binddns-formula <https://github.com/bechtoldt/binddns-formula>`_
* `iscdhcp-formula <https://github.com/bechtoldt/iscdhcp-formula>`_
* `network-formula <https://github.com/bechtoldt/network-formula>`_
* `time-formula <https://github.com/bechtoldt/time-formula>`_
* `tftp-formula <https://github.com/bechtoldt/tftp-formula>`_
* `libvirt-formula <https://github.com/bechtoldt/libvirt-formula>`_

`Mail me <https://github.com/bechtoldt>`_ if you know additional, compatible Salt Stack formulas.

Formula Dependencies
====================

None

Contributions
=============

Contributions are always welcome. All development guidelines you have to know are

* write clean code (proper YAML+Jinja syntax, no trailing whitespaces, no empty lines with whitespaces, LF only)
* set sane default settings
* test your code
* update README.rst doc

Salt Compatibility
==================

Tested with:

* 2014.1.4

OS Compatibility
================

Tested with:

* GNU/ Linux Debian Wheezy
