#!jinja|yaml

{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}

include:
  - foreman.proxy

{{ salt['pillar.get']('tftp:lookup:root', '/srv/tftp') }}/pxelinux.cfg:
  file:
    - directory
    - user: {{ datamap.proxy.user.name|default('foreman-proxy') }}
    - mode: 755

{{ salt['pillar.get']('tftp:lookup:root', '/srv/tftp') }}/boot:
  file:
    - directory
    - user: {{ datamap.proxy.user.name|default('foreman-proxy') }}
    - mode: 755

{{ salt['pillar.get']('tftp:lookup:root', '/srv/tftp') }}/pxelinux.0:
  file:
    - copy
    - source: {{ salt['pillar.get']('foreman:lookup:syslinux_root', '/usr/lib/syslinux') }}/pxelinux.0

{{ salt['pillar.get']('tftp:lookup:root', '/srv/tftp') }}/menu.c32:
  file:
    - copy
    - source: {{ salt['pillar.get']('foreman:lookup:syslinux_root', '/usr/lib/syslinux') }}/menu.c32

{{ salt['pillar.get']('tftp:lookup:root', '/srv/tftp') }}/chain.c32:
  file:
    - copy
    - source: {{ salt['pillar.get']('foreman:lookup:syslinux_root', '/usr/lib/syslinux') }}/chain.c32

{{ salt['pillar.get']('tftp:lookup:root', '/srv/tftp') }}/memdisk:
  file:
    - copy
    - source: {{ salt['pillar.get']('foreman:lookup:syslinux_root', '/usr/lib/syslinux') }}/memdisk
