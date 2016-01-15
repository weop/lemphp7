class nginx {

	exec { 'service nginx restart':
		command => 'sudo service nginx restart',
		path => '/usr/bin',
		require => [
			Package['nginx'],
			File['nginx-vhost'],
			File['disable-nginx-default'],
			File['enable-nginx-vhost'],
		],
	}

	file { '/var/www/app':
	  ensure  => 'link',
	  target  => '/vagrant/app',
	}

	file { '/home/vagrant/app':
	  ensure  => 'link',
	  target  => '/vagrant/app',
	}

	package { 'nginx':
	  ensure => 'present',
	  require => Exec['apt-get update'],
	}

	service { 'nginx':
	  ensure => running,
	  require => Package['nginx'],
	}

	file { 'nginx-vhost':
	  path => '/etc/nginx/sites-available/nginx_vhost',
	  ensure => file,
	  require => Package['nginx'],
	  source => 'puppet:///modules/nginx/nginx_vhost',
	}

	file { 'disable-nginx-default':
	  path => '/etc/nginx/sites-enabled/default',
	  ensure => absent,
	  require => Package['nginx'],
	}

	file { 'enable-nginx-vhost':
	    path => '/etc/nginx/sites-enabled/nginx_vhost',
	    target => '/etc/nginx/sites-available/nginx_vhost',
	    ensure => link,
	    notify => Service['nginx'],
	    require => [
	        File['nginx-vhost'],
	        File['disable-nginx-default'],
	    ],
	}

}
