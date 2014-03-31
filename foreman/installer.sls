{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}

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
      - pkg: foreman
