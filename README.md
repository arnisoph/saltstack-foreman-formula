# foreman-formula

Salt Stack Formula to set up and configure the lifecycle management tool Foreman

## NOTICE BEFORE YOU USE

* This formula aims to follow the conventions and recommendations described at [http://docs.saltstack.com/topics/conventions/formulas.html](http://docs.saltstack.com/topics/conventions/formulas.html)

## TODO

The long-term goal is to have a comfortable formula and all Puppet modules used by the foreman-installer (kafo) to be replaced by e.g. Salt Stack Formulas.

* do initial Foreman setup (domains, proxies, OSs, etc.) with hammer CLI
* foreman-proxy: use https://github.com/bechtoldt/tftp-formula
* foreman-proxy: to tftp setup, see https://github.com/theforeman/puppet-foreman_proxy/blob/master/manifests/tftp.pp

## Instructions

1. Add this repository as a [GitFS](http://docs.saltstack.com/topics/tutorials/gitfs.html) backend in your Salt master config.

2. Configure your Pillar top file (`/srv/pillar/top.sls`), see pillar.example

3. Include this Formula within another Formula or simply define your needed states within the Salt top file (`/srv/salt/top.sls`).

## Available states

### foreman

Installs the foreman repo, the foreman-installer (kafo based) package and runs it.

## Additional resources

See [http://theforeman.org/manuals/1.4/index.html#3.2ForemanInstaller](http://theforeman.org/manuals/1.4/index.html#3.2ForemanInstaller) (or newer doc)

## Formula Dependencies

None

## Compatibility

*DOES* work on:

* GNU/ Linux Debian Wheezy

*SHOULD* work on:

* GNU/ Linux Debian Squeeze
* Ubuntu Precise
