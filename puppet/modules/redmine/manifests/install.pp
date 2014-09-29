class redmine::install {
  Exec {
    path        => ['/bin','/usr/bin'],
    environment => ['HOME=/root','RAILS_ENV=production','REDMINE_LANG=en'],
    provider    => 'shell',
    cwd         => '/var/www/redmine',
  }

  package { ['ruby-devel', 'mysql-devel', 'apr-devel', 'apr-util-devel']:
    ensure => present,
    provider => yum,
  }
  ->
  package { ['bundler']:
    ensure => present,
    provider => gem,
  }
  ->
  vcsrepo { '/var/www/redmine':
    ensure => present,
    provider => git,
    source => "https://github.com/redmine/redmine",
  }
  ->
  exec { "bundle":
    command => "bundle install --gemfile ${redmine::docroot}/Gemfile --without development test postgresql sqlite rmagick",
    unless => 'bundle check',
    timeout => 0,
  }
}
