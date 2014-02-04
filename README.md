# foreman-formula

Salt Stack Formula to set up and configure the lifecycle management tool Foreman

## TODO

The long-term goal is to have a comfortable formula and all Puppet modules used by the foreman-installer (kafo) to be replaced by e.g. Salt Stack Formulas.

## Instructions

1. Add this repository as a [GitFS](http://docs.saltstack.com/topics/tutorials/gitfs.html) backend in your Salt master config.

2. Configure your Pillar top file (`/srv/pillar/top.sls`), see pillar.example

3. Include this Formula within another Formula or simply define your needed states within the Salt top file (`/srv/salt/top.sls`).

## Available states

### foreman

Installs the foreman repo, the foreman-installer package and runs it.

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
