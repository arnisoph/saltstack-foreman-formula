#!jinja|yaml

{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}

foreman_console:
  pkg:
    - installed
    - pkgs: {{ datamap.console.pkgs }}
