#!jinja|yaml

{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}


include:
  - foreman
  - foreman.webfrontend._user
{% for si in salt['pillar.get']('foreman:lookup:webfrontend:sls_include', []) %}
  - {{ si }}
{% endfor %}

extend: {{ salt['pillar.get']('foreman:lookup:webfrontend:sls_extend', '{}') }}
{#
{-% for k, v in salt['pillar.get']('opennebula:lookup:sunstone:sls_extend', {}).items() }-}
  {-{ k }-}: {-{ v }-}
{-% endfor }-}
#}

dbdriver:
  pkg:
    - installed
    - pkgs: {{ datamap.webfrontend['dbdriver_' ~ datamap.webfrontend.db_type|default('postgresql')].pkgs|default([]) }}

webfrontend:
  pkg:
    - installed
    - pkgs: {{ datamap.webfrontend.pkgs|default([]) }}

{% if 'settings_yaml' in datamap.webfrontend.config.manage|default([]) %}
settings_yaml:
  file:
    - name: {{ datamap.webfrontend.config.settings_yaml.path|default('/etc/foreman/settings.yaml') }}
    #- serialize
    - managed
    #- dataset:
    #    {# { datamap.webfrontend.config.settings_yaml.content|default({}) } #}
    #- formatter: YAML
    - contents_pillar: foreman:lookup:webfrontend:config:settings_yaml:content
    - mode: 640
    - user: root
    - group: {{ datamap.webfrontend.group.name|default('foreman') }}
{% endif %}

{% if 'database_yml' in datamap.webfrontend.config.manage|default([]) %}
database_yml:
  file:
    - name: {{ datamap.webfrontend.config.database_yml.path|default('/etc/foreman/database.yml') }}
    #- serialize
    - managed
    #- dataset:
        #{# { datamap.webfrontend.config.database_yml.content|default({}) } #}
    #- formatter: YAML
    - contents_pillar: foreman:lookup:webfrontend:config:database_yml:content
    - mode: 640
    - user: root
    - group: {{ datamap.webfrontend.group.name|default('foreman') }}
{% endif %}

{% set db_prep_cmds = [
  '/usr/sbin/foreman-rake db:migrate &&',
  '/usr/sbin/foreman-rake db:seed &&',
  '/usr/sbin/foreman-rake apipie:cache',
] %}

prepare_database:
  cmd:
    - wait
    - name: {{ db_prep_cmds|join(' ') }}
    - user: {{ datamap.webfrontend.user.name|default('foreman') }}
    - watch:
      - file: database_yml

{% if 'cron' in datamap.webfrontend.config.manage|default([]) %}
cron: {# TODO: we should SIGHUP cron daemon #}
  file:
    - managed
    - name: {{ datamap.webfrontend.config.cron.path|default('/etc/cron.d/foreman') }}
    - source: {{ datamap.webfrontend.config.cron.template_path|default('salt://foreman/files/webfrontend/cron') }}
    - mode: 644
    - user: root
    - group: root
    - template: jinja
{% endif %}
