#!jinja|yaml

{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}

include:
  - foreman

foreman_cli:
  pkg:
    - installed
    - pkgs:
{% for p in datamap.cli.pkgs %}
      - {{ p }}
{% endfor %}
