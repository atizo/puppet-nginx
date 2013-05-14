class nginx {
  package{'nginx':
    ensure => installed,
  }
  service{'nginx':
    ensure => running,
    enable => true,
    hasstatus => false, 
    require => Package['nginx'],
  }
  file{'/etc/nginx/conf':
    source => [
      "puppet://$server/modules/site-nginx/$fqdn/conf",
      "puppet://$server/modules/site-nginx/$operatingsystem/conf",
      "puppet://$server/modules/site-nginx/conf",
      "puppet://$server/modules/nginx/$operatingsystem/conf",
      "puppet://$server/modules/nginx/conf",
    ],
    require => Package['nginx'],
    notify => Service['nginx'],
    recurse => true,
    owner => root, group => 0, mode => 0440;
  }
  nginx::configfile{[
    'nginx.conf',
    'mime.types',
  ]:}
}
