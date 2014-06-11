#!jinja|yaml

{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}

include:
  - foreman

foreman_installer:
  pkg:
    - installed
    - pkgs:
{% for p in datamap.foreman_installer.pkgs %}
      - {{ p }}
{% endfor %}
  cmd:
    - wait
    - name: {{ datamap.foreman_installer.path }}{% for param in datamap.foreman_installer.params_basic %} --{{ param }}{% endfor %}{% for param in datamap.foreman_installer.params_puppetmodules %} --{{ param }}{% endfor %}
    - watch:
      - pkg: foreman_installer

foreman-group-membership-sslcert:
  cmd:
    - run
    - name: usermod foreman -a -G ssl-cert
    - onlyif: test -z "$(groups foreman | grep ssl-cert)"
    - require:
      - cmd: foreman_installer
