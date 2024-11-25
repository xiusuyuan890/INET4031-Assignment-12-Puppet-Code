package { 'apache2':
  ensure => installed,
}

package { 'php':
  ensure => installed,
  notify  => Service['apache2'],
  require => [Package['apache2']],
}

package { 'php-mysql':
  ensure  => installed,
  require => [Package['php']],
}

file { '/var/www/html/phpinfo.php':
  source => '/home/xiusu/puppet-dev/phpinfo.php',
  notify  => Service['apache2'],
  require => [Package['apache2']]

}

service { 'apache2':
  ensure => running,
  enable => true,
  require => [Package['apache2'], Package['php']]
}

package { 'mariadb-server':
  ensure => installed,
}

service { 'mariadb':
  ensure  => running,
  enable  => true,
  require => Package['mariadb-server'],
}
