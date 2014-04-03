{% from "foreman/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('foreman:lookup')) %}

{% if datamap.repo.manage|default(True) == True %}
  {% if salt['grains.get']('os_family') == 'Debian' %}
foreman_repo:
  pkgrepo:
    - managed
    - name: deb {{ datamap.repo.url }} {{ datamap.repo.dist }} {{ datamap.repo.comps }}
    - file: /etc/apt/sources.list.d/foreman.list
    - key_url: {{ datamap.repo.keyurl }}
  {% endif %}
{% endif %}


{#
  #################
  Generate a self signed CA + Certficate for Foreman web GUI and Foreman Smart Proxy. Replace the code as soon as SaltStack has builtin TLS CA/CRT  (not released yet)

  DON'T USE IT IN PRODUCTION!
  #################
#}

/var/tmp/myca.ca.crt.csr:
  cmd:
    - run
    - name: openssl req -nodes -subj "/C=DE/ST=Baden-Wuerttemberg/L=Karlsruhe/O=Organization XY/OU=IT/CN=My Certificate Authority/emailAddress=mail@arnoldbechtoldt.com" -new > /var/tmp/myca.ca.crt.csr
    - cwd: /var/tmp
    - unless: test -f /var/tmp/myca.ca.crt.csr

/etc/ssl/private/myca.ca.key:
  cmd:
    - run
    - name: openssl rsa -in /var/tmp/privkey.pem -out /etc/ssl/private/myca.ca.key
    - cwd: /var/tmp
    - unless: test -f /etc/ssl/private/myca.ca.key

/etc/ssl/certs/myca.ca.crt:
  cmd:
    - run
    - name: openssl x509 -in /var/tmp/myca.ca.crt.csr -out /etc/ssl/certs/myca.ca.crt -req -signkey /etc/ssl/private/myca.ca.key -days 365
    - unless: test -f /etc/ssl/certs/myca.ca.crt

/var/tmp/{{ salt['grains.get']('fqdn') }}.crt.csr:
  cmd:
    - run
    - name: openssl req -nodes -subj "/C=DE/ST=Baden-Wuerttemberg/L=Karlsruhe/O=Organization XY/OU=IT/CN={{ salt['grains.get']('fqdn') }}/emailAddress=mail@arnoldbechtoldt.com" -new > /var/tmp/{{ salt['grains.get']('fqdn') }}.crt.csr
    - cwd: /var/tmp
    - unless: test -f /var/tmp/{{ salt['grains.get']('fqdn') }}.crt.csr

/etc/ssl/private/{{ salt['grains.get']('fqdn') }}.key:
  cmd:
    - run
    - name: openssl rsa -in /var/tmp/privkey.pem -out /etc/ssl/private/{{ salt['grains.get']('fqdn') }}.key
    - cwd: /var/tmp
    - unless: test -f /etc/ssl/private/{{ salt['grains.get']('fqdn') }}.key

/etc/ssl/certs/{{ salt['grains.get']('fqdn') }}.crt:
  cmd:
    - run
    - name: openssl x509 -req -in /var/tmp/{{ salt['grains.get']('fqdn') }}.crt.csr -out /etc/ssl/certs/{{ salt['grains.get']('fqdn') }}.crt -signkey /etc/ssl/private/{{ salt['grains.get']('fqdn') }}.key -CA /etc/ssl/certs/myca.ca.crt -CAkey /etc/ssl/private/myca.ca.key -CAcreateserial -days 42
    - unless: test -f /etc/ssl/certs/{{ salt['grains.get']('fqdn') }}.crt

