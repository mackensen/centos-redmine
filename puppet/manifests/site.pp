node 'vcr' {
  vcsrepo { "/var/www/redmine":
    ensure => present,
    provider => git,
    source => "https://github.com/redmine/redmine",
  }

  apache::vhost { 'local.redmine.dev':
    port => '80',
    docroot => '/var/www/redmine/public',
    require => File['/var/www/redmine'],
  }

  file { ['/var/www', '/var/www/redmine']:
    ensure => directory
  }

  class {'passenger': }

  class { 'mysql::server':
    root_password => 'password'
  }

  mysql::db { 'redmine':
    user => 'redmine',
    password => 'password',
    host => 'localhost',
    grant => ['all'],
    charset => 'utf8',
  }

  include redmine
}
