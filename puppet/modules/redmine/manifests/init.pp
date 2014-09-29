class redmine {
  Exec {
    path        => ['/bin','/usr/bin'],
    environment => ['HOME=/root','RAILS_ENV=production','REDMINE_LANG=en'],
    provider    => 'shell',
    cwd         => '/var/www/redmine',
  }

  file { '/var/www/redmine/config/database.yml':
    replace => no, 
    ensure => present,
    source => 'puppet:///modules/redmine/database.yml',
  }

  package { ['ruby-devel', 'mysql-devel', 'apr-devel', 'apr-util-devel']:
    ensure => present,
    provider => yum,
  }

  package { ['rake']:
    ensure => present,
    provider => gem,
  }
  ->
  bundler::install { '/var/www/redmine':
    user => 'root',
    group => 'root',
    deployment => false,
    without => 'development test postgresql sqlite rmagick',
    timeout => 0,
  }
  ->
  exec { 'session-token':
    command => '/usr/bin/rake generate_secret_token && /bin/touch .secret_token',
    creates => '/var/www/redmine/.secret_token',
    require => Package['rake'],
  } 
  ->
  exec { 'rake-migration':
    command => '/usr/bin/rake db:migrate && /bin/touch .migrate',
    creates => '/var/www/redmine/.migrate',
    require => Package['rake'],
  }
  ->
  exec { 'rake-default':
    command => '/usr/bin/rake redmine:load_default_data && /bin/touch .default',
    creates => '/var/www/redmine/.default',
    require => Package['rake'],
  }
}
