foreman:
  lookup:
    repo_comps: '1.4'
    kafo_installer:
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
