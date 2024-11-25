# puppet-dev code
  The files in this directory contains two things
    1. What users should be on a server, the codes are:
    
group { 'group01':
  ensure => present,
}

group { 'group02':
  ensure => present,
}

user { 'user04':
  ensure => present,
  shell => '/bin/bash',
  password => '$6$xyz$RS.wHeM.mhNC0lxrp5Zds0ubSAKobEjpYvIWroBijzmu0tuqfQ1C6iBejYnxrEonuCOM0jgFUF3Dc038gW2.D.',
  groups => 'group01',
  managehome => true,
}

user { 'user05':
  ensure => present,
  shell => '/bin/bash',
  password => '$6$xyz$fvqDLmx0wy4IIDQ2f1XgA0lTJJAecH9QVTiHNFfhLVE/PYAaCbYXgqORdpPmWD9q36FjqhQAB3cC7DpV82r2f1',
  groups => 'group02',
  managehome => true,
}    

user { 'user06':
  ensure => present,
  shell => '/bin/bash',
  password => '$6$xyz$0RT6mRekQHKdXyWm/wFA06pcoh9KiH9HgdzELyXsmHKHGV6/h6VnAs44BLlVCXvMvi4Ju9c6VAeTMK3.4TjLm1',
  groups => ['group01','group02'],
  managehome => true,
}

user { 'user07':
  ensure => present,
  shell => '/bin/bash',
  password => '$6$xyz$zlj5PnjldM6pveJoYYpAfowmR81rqqtgs9Xh5ikn.oRf8GxSSR4XOoi1El1Wu7rhkUrS20.oNBN1NkWRW5Tb60',
  managehome => true,
}
    
    2. What packages should be installed on a LAMP Stack server, the codes are: 
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
