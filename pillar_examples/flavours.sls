{# Using foreman installer #}
foreman:
  lookup:
    repo_comps: '1.4'
    foreman_installer:
      params_puppetmodules:
        - foreman-locations-enabled=true
        - foreman-proxy-dhcp-interface=br0
        - foreman-proxy-dhcp-managed=true
        - foreman-proxy-dhcp-nameservers=172.16.34.10
        - foreman-proxy-dns-forwarders=8.8.8.8
        - foreman-proxy-dns-forwarders=192.168.2.1
        - foreman-proxy-dns-interface=br0
        - foreman-proxy-dns-managed=true
        - foreman-proxy-dns-reverse=34.16.172.in-addr.arpa
        - foreman-proxy-dns-zone=be1-net.local
        - foreman-proxy-dhcp-range="172.16.34.150 172.16.34.200"
        - foreman-proxy-dhcp-gateway=172.16.34.1
        - foreman-proxy-tftp=false

{# Using formula's functions but use puppet based foreman-installer to install foreman #}
foreman:
  lookup:
    foreman_installer:
      params_puppetmodules:
        - no-enable-foreman-proxy
        - no-enable-puppet
    proxy:
      user:
        optional_groups:
          - foreman-proxy
          - ssl-cert
      config:
        settings_yaml:
          contents: |
            :daemon_pid: /var/run/foreman-proxy/foreman-proxy.pid
            :daemon: true
            :log_file: /var/log/foreman-proxy/foreman-proxy.log
            :log_level: DEBUG
            :ssl_certificate: /etc/ssl/certs/foreman.prod.be1-net.local.crt
            :ssl_ca_file: /etc/ssl/certs/foreman.prod.be1-net.local.ca.crt
            :ssl_private_key: /etc/ssl/private/foreman.prod.be1-net.local.key
            :https_port: 8443
            :settings_directory: /etc/foreman-proxy/settings.d
        dhcp_yaml:
          contents: |
            :enabled: false
            :dhcp_config: /etc/dhcp/dhcpd.conf
            :dhcp_leases: /var/lib/dhcp/dhcpd.leases
            :dhcp_vendor: isc
        dns_yaml:
          contents: |
            :enabled: true
            :dns_key: /etc/bind/rndc.key
            :dns_server: 127.0.0.1
        tftp_yaml:
          contents: |
            :enabled: false
            :tftproot: /srv/tftp
            :tftp_servername: foreman.prod.be1-net.local
        puppet_yaml:
          contents: |
            :enabled: false
        puppetca_yaml:
          contents: |
            :enabled: false
        bmc_yaml:
          contents: |
            :enabled: false
            :bmc_default_provider: ipmitool
    plugins:
      manage:
        - bootdisk

{# Install Foreman webinterface #}
foreman:
  lookup:
    webfrontend:
      sls_include:
        - crypto.x509
      sls_extend:
        crypto-x509-key-foreman_key:
          file:
            - require:
              - group: foreman
      user:
        optional_groups:
          - foreman
          - ssl-cert
      config:
        database_yml:
          content: |
            # SQLite version 3.x
            development:
              adapter: sqlite3
              database: db/development.sqlite3
              pool: 5
              timeout: 5000

            # Warning: The database defined as "test" will be erased and
            # re-generated from your development database when you run "rake".
            # Do not set this db to the same as development or production.
            test:
              adapter: sqlite3
              database: db/test.sqlite3
              pool: 5
              timeout: 5000

            # Database is managed by foreman::database::postgresql
            production:
              host: postgres.domain.local
              adapter: postgresql
              database: foreman
              username: foreman
              password: "42"

        settings_yaml:
          content: |
            unattended: true
            puppetconfdir: /etc/puppet/puppet.conf
            login: true
            require_ssl: false
            locations_enabled: false
            organizations_enabled: false

            # The following values are used for providing default settings during db migrate
            oauth_active: true
            oauth_map_users: true
            oauth_consumer_key: foo
            oauth_consumer_secret: bar
