class redmine::rake {
  Exec {
    path        => ['/bin','/usr/bin'],
    environment => ['HOME=/root','RAILS_ENV=production','REDMINE_LANG=en'],
    provider    => 'shell',
    cwd         => '/var/www/redmine',
  }

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
