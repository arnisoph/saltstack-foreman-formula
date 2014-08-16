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
    - name: {{ datamap.proxy.config.settings_yaml.path }}
    #- serialize
    - managed
    #- dataset:
    #    {# datamap.proxy.config.settings|default({}) #}
    #- formatter: YAML
    - contents_pillar: foreman:lookup:proxy:config:settings
    - mode: 644
    - user: {{ datamap.proxy.user.name|default('foreman-proxy') }}
    - group: {{ datamap.proxy.group.name|default('foreman-proxy') }}
{% endif %}
