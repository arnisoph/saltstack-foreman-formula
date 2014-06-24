#!jinja|yaml

{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}

include:
  - foreman
  - foreman.proxy._user
{% for si in salt['pillar.get']('foreman:lookup:preoxy:sls_include', []) %}
  - {{ si }}
{% endfor %}

extend: {{ salt['pillar.get']('foreman:lookup:proxy:sls_extend', '{}') }}
{#
{-% for k, v in salt['pillar.get']('opennebula:lookup:sunstone:sls_extend', {}).items() }-}
  {-{ k }-}: {-{ v }-}
{-% endfor }-}
#}

proxy:
  pkg:
    - installed
    - pkgs: {{ datamap.proxy.pkgs|default(['foreman-proxy']) }}
  service:
    - running
    - name: {{ datamap.proxy.service.name|default('foreman-proxy') }}
    - enable: {{ datamap.proxy.service.enable|default(True) }}
    - watch:
{% for c in datamap.proxy.config.manage|default([]) %}
      - file: {{ c }}
{% endfor %}
    - require:
      - pkg: proxy

{% if 'settings_yaml' in datamap.proxy.config.manage|default([]) %}
settings_yaml:
  file:
    - serialize
    - name: {{ datamap.proxy.config.settings_yml.path }}:
    - dataset:
        {{ datamap.proxy.config.settings|default({}) }}
    - formatter: YAML
    - mode: 644
    - user: {{ datamap.proxy.user.name|default('foreman-proxy') }}
    - group: {{ datamap.proxy.group.name|default('foreman-proxy') }}
{% endif %}
