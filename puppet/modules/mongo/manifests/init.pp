class mongo {

	package { [
		'mongodb',
		]:
		ensure => present,
	}

}
