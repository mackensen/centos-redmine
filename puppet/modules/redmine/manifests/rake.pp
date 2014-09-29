class redmine::rake {
  Exec {
    path        => ['/bin','/usr/bin'],
    environment => ['HOME=/root','RAILS_ENV=production','REDMINE_LANG=en'],
    provider    => 'shell',
    cwd         => "${redmine::docroot}",
  }

  exec { 'session-token':
    command => '/usr/bin/rake generate_secret_token && /bin/touch .secret_token',
    creates => "${redmine::docroot}/.secret_token",
  }
  ->
  exec { 'rake-migration':
    command => '/usr/bin/rake db:migrate && /bin/touch .migrate',
    creates => "${redmine::docroot}/.migrate",
  }
  ->
  exec { 'rake-default':
    command => '/usr/bin/rake redmine:load_default_data && /bin/touch .default',
    creates => "${redmine::docroot}/.default",
  }
}
