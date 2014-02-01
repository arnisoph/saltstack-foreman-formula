{% from "foreman/map.jinja" import foreman with context %}

{% if foreman['manage_foremanrepo'] %}
  {% if salt['grains.get']('os_family') == 'Debian' %}
foreman_repo:
  pkgrepo:
    - managed
    - name: deb {{ foreman['repo_url'] }} {{ foreman['repo_dist'] }} {{ foreman['repo_comps'] }}
    - file: /etc/apt/sources.list.d/foreman.list
    - key_url: {{ foreman['repo_keyurl'] }}
  {% endif %}
{% endif %}

foreman:
  pkg:
    - installed
    - name: foreman-installer
  cmd:
    - wait
    - name: {{ foreman['foreman_installer_path'] }}{% for param in foreman['foreman_installer_params_basic'] %} --{{ param }}{% endfor %}{% for param in foreman['foreman_installer_params_puppetmodules'] %} --{{ param }}{% endfor %}
    - watch:
      - pkg: foreman
