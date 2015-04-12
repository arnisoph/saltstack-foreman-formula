#!jinja|yaml

{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}

foreman_proxy_user:
  user:
    - present
    - name: {{ datamap.proxy.user.name|default('foreman-proxy') }}
    #- uid: {{ datamap.proxy.user.uid|default(999) }}
    #- gid: {{ datamap.proxy.group.gid|default(999) }}
    - groups: {{ datamap.proxy.user.groups|default(['foreman-proxy']) }}
    - optional_groups: {{ datamap.proxy.user.optional_groups|default(['foreman-proxy']) }}
    - home: {{ datamap.proxy.user.home|default('/usr/share/foreman-proxy') }}
    - shell: {{ datamap.proxy.user.shell|default('/usr/sbin/nologin') }}
    - createhome: True
    - system: True
    - require:
      - group: foreman_proxy_user
  group:
    - present
    - name: {{ datamap.proxy.group.name|default('foreman-proxy') }}
    #- gid: {{ datamap.proxy.group.gid|default(999) }}
    - system: True
  file:
    - directory
    - name: {{ datamap.proxy.user.home|default('/usr/share/foreman-proxy') }}
    - mode: 755
    - user: {{ datamap.proxy.user.name|default('root') }}
    - group: {{ datamap.proxy.group.name|default('root') }}
    - require:
      - user: foreman_proxy_user
