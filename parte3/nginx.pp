package { 'nginx':
  ensure => installed,
}

file { '/var/www/html':
  ensure => directory,
  owner  => 'www-data',
  group  => 'www-data',
  mode   => '0755',
}

file { '/var/www/html/index.html':
  ensure  => file,
  content => "<h1>Nginx gerenciado pelo Puppet</h1>\n",
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0644',
}

file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('/home/rafa/umbler-desafio/parte3/templates/default.conf.erb'),
  notify  => Service['nginx'],
}

file { '/etc/nginx/sites-enabled/default':
  ensure => link,
  target => '/etc/nginx/sites-available/default',
  notify => Service['nginx'],
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
