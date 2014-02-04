{% from "foreman/map.jinja" import foreman_map with context %}

{% if foreman_map['manage_foremanrepo'] %}
  {% if salt['grains.get']('os_family') == 'Debian' %}
foreman_repo:
  pkgrepo:
    - managed
    - name: deb {{ foreman_map['repo_url'] }} {{ foreman_map['repo_dist'] }} {{ foreman_map['repo_comps'] }}
    - file: /etc/apt/sources.list.d/foreman.list
    - key_url: {{ foreman_map['repo_keyurl'] }}
  {% endif %}
{% endif %}

foreman:
  pkg:
    - installed
    - name: foreman-installer
  cmd:
    - wait
    - name: {{ foreman_map['foreman_installer_path'] }}{% for param in foreman_map['foreman_installer_params_basic'] %} --{{ param }}{% endfor %}{% for param in foreman_map['foreman_installer_params_puppetmodules'] %} --{{ param }}{% endfor %}
    - watch:
      - pkg: foreman
