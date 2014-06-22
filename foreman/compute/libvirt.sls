#!jinja|yaml

{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}

include:
  - foreman.compute

foreman_compute_libvirt:
  pkg:
    - installed
    - pkgs: {{ datamap.compute.libvirt.pkgs|default([]) }}
