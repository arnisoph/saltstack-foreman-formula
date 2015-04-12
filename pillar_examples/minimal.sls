repos:
  lookup:
    repos:
      foreman:
        url: http://deb.theforeman.org/
        keyurl: http://deb.theforeman.org/foreman.asc
        dist: wheezy
        comps:
          - stable

foreman:
  lookup:
    webfrontend:
      config:
        manage: []
    proxy:
      config:
        manage: []
