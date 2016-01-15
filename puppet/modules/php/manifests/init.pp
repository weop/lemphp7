class php {

	exec { 'restarting... php7.0-fpm':
	  command => 'sudo service php7.0-fpm restart',
	  path    => ['/bin', '/usr/bin'],
	  require => File['php-ini'],
	}

	file { 'php-ini':
	  path => '/etc/php/7.0/fpm/php.ini',
	  ensure => present,
	  source => 'puppet:///modules/php/php.ini',
	  require => Service['php7.0-fpm'],
	}

	file { 'php-error-log':
    path => '/var/log/php_errors.log',
	  ensure => present,
		owner  => 'www-data',
    group  => 'adm',
	  require => File['php-ini'],
  }

	service { 'php7.0-fpm':
	  ensure => running,
	  require => [
	  	Package['php7.0'],
			Package['php7.0-fpm'],
	  ]
	}

	package { [
		'php7.0',
		'php7.0-fpm',
		'php7.0-mysql',
	  ]:
	  ensure => present,
	  require => Exec['apt-get update && purge php 5'],
	}

	exec { 'apt-get update && purge php 5':
	  command => 'sudo apt-get update && sudo apt-get purge php5-fpm && sudo apt-get --purge autoremove',
	  path    => ['/bin', '/usr/bin'],
	  require => Exec['apt-add ondrej/php'],
	}

	exec { 'apt-add ondrej/php':
	  command => 'sudo apt-add-repository ppa:ondrej/php-7.0 -y',
	  path    => ['/bin', '/usr/bin'],
	  require => Exec['php pre-install tasks'],
	}

	exec { 'php pre-install tasks':
	  command => 'sudo apt-get install -y language-pack-en-base && sudo locale-gen && export LC_ALL="en_US.UTF-8" && export LANG="en_US.UTF-8" && sudo apt-get install -y software-properties-common',
	  path    => ['/bin', '/usr/bin'],
	}

}
