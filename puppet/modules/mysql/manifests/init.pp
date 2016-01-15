class mysql {

  package { ['mysql-server']:
    ensure => present,
    require => Exec['apt-get update'],
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

  exec { 'importing app/sql.db':
    command => 'pv -n /vagrant/app/db.sql | mysql -u root -proot -D localdb',
    path    => ['/bin', '/usr/bin'],
    require => Exec['create localdb']
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
