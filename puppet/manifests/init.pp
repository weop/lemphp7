
exec { 'apt-get update':
  command => 'sudo apt-get update && sudo apt-get upgrade -y',
  path => '/usr/bin',
}

package { [
  'vim',
  'pv',
  ]:
  ensure => present,
  require => Exec['apt-get update'],
}

file { '/var/www/':
  ensure => 'directory',
}

exec { 'locale-fix':
  command => 'sudo touch /var/lib/cloud/instance/locale-check.skip',
  path => '/usr/bin'
}

include nginx, php, mysql
