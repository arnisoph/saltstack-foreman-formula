{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}

{% if datamap['manage_foremanrepo'] == True %}
  {% if salt['grains.get']('os_family') == 'Debian' %}
foreman_repo:
  pkgrepo:
    - managed
    - name: deb {{ datamap['repo_url'] }} {{ datamap['repo_dist'] }} {{ datamap['repo_comps'] }}
    - file: /etc/apt/sources.list.d/foreman.list
    - key_url: {{ datamap['repo_keyurl'] }}
  {% endif %}
{% endif %}

foreman:
  pkg:
    - installed
    - name: foreman-installer
  cmd:
    - wait
    - name: {{ datamap['foreman_installer_path'] }}{% for param in datamap['foreman_installer_params_basic'] %} --{{ param }}{% endfor %}{% for param in datamap['foreman_installer_params_puppetmodules'] %} --{{ param }}{% endfor %}
    - watch:
      - pkg: foreman
