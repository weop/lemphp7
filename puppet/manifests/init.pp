package { [
  'vim',
  'pv',
  ]:
  ensure => present,
}

file { '/var/www/':
  ensure => 'directory',
}

include nginx, php, mysql
