#!jinja|yaml

{# TODO:
  * rename to _plugins and include in webfrotend and smartproxy?
  * plugin install may require internet access due to "bundle update" in postinst scripts in the debian pkgs
#}

{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}

{% for p in datamap.plugins.manage|default([]) %}
plugin_{{ p }}: {# TODO: reload/ restart foreman #}
  pkg:
    - installed
    - name: ruby-foreman-{{ p }}
{% endfor %}
