class mysql {

  package { ['mysql-server']:
    ensure => present,
  }

  service { 'mysql':
    ensure  => running,
    require => Package['mysql-server'],
  }

  file { '/etc/mysql/my.cnf':
    ensure => present,
    source  => 'puppet:///modules/mysql/my.cnf',
    require => Package['mysql-server'],
    notify  => Service['mysql'],
  }

  exec { 'set-mysql-password':
    unless  => 'mysqladmin -uroot -proot password root',
    command => 'mysqladmin -uroot password root',
    path    => ['/bin', '/usr/bin'],
    require => Service['mysql'];
  }

  exec { 'create localdb':
    command => 'mysql -u root -proot -e "CREATE DATABASE IF NOT EXISTS localdb;"',
    path    => ['/bin', '/usr/bin'],
    require => [
      File['/etc/mysql/my.cnf'],
      Exec['set-mysql-password'],
      Service['mysql'],
    ]
  }


}
