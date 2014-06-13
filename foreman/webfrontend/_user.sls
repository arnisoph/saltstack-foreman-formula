#!jinja|yaml

{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}

include:
  - foreman

foreman:
  user:
    - present
    - name: {{ datamap.webfrontend.user.name|default('foreman') }}
    - uid: {{ datamap.webfrontend.user.uid|default(998) }}
    - gid: {{ datamap.webfrontend.group.gid|default(998) }}
    - groups: {{ datamap.webfrontend.user.groups|default(['foreman']) }}
    - optional_groups: {{ datamap.webfrontend.user.optional_groups|default(['foreman']) }}
    - home: {{ datamap.webfrontend.user.home|default('/usr/share/foreman') }}
    - shell: {{ datamap.webfrontend.user.shell|default('/bin/false') }}
    - createhome: True
    - system: True
    - require:
      - group: foreman
  group:
    - present
    - name: {{ datamap.webfrontend.group.name|default('foreman') }}
    - gid: {{ datamap.webfrontend.group.gid|default(998) }}
    - system: True
  file:
    - directory
    - name: {{ datamap.webfrontend.user.home|default('/usr/share/foreman') }}
    - mode: 755
    - user: {{ datamap.webfrontend.user.name|default('foreman') }}
    - group: {{ datamap.webfrontend.group.name|default('foreman') }}
    - require:
      - user: foreman
