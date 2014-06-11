#!jinja|yaml

{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}

include:
  - foreman.compute

foreman-compute-libvirt:
  pkg:
    - installed
    - pkgs:
{% for p in datamap.compute.libvirt.pkgs %}
      - {{ p }}
{% endfor %}
