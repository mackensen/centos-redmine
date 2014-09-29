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
  package { ['rake']:
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
  bundler::install { '/var/www/redmine':
    user => 'root',
    group => 'root',
    deployment => false,
    without => 'development test postgresql sqlite rmagick',
    timeout => 0,
  }
}
