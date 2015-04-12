#!jinja|yaml

{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}

include:
  - foreman.proxy._user
{% for si in salt['pillar.get']('foreman:lookup:proxy:sls_include', []) %}
  - {{ si }}
{% endfor %}

extend: {{ salt['pillar.get']('foreman:lookup:proxy:sls_extend', '{}') }}

foreman_proxy:
  pkg:
    - installed
    - pkgs: {{ datamap.proxy.pkgs|default(['foreman-proxy']) }}
  service:
    - running
    - name: {{ datamap.proxy.service.name|default('foreman-proxy') }}
    - enable: {{ datamap.proxy.service.enable|default(True) }}
    - require:
      - pkg: foreman_proxy

{% for c in datamap.proxy.config.manage|default([]) %}
foreman_proxy_config_{{ c }}:
  file:
    - name: {{ datamap.proxy.config[c].path }}
    #- serialize
    - managed
    #- dataset:
    #    {# datamap.proxy.config.settings|default({}) #}
    #- formatter: YAML
    - contents_pillar: foreman:lookup:proxy:config:{{ c }}:contents
    - mode: 644
    - user: {{ datamap.proxy.user.name|default('root') }}
    - group: {{ datamap.proxy.group.name|default('root') }}
    - watch_in:
      - service: foreman_proxy
{% endfor %}
