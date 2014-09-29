class redmine::config {
  file { '/var/www/redmine/config/database.yml':
    replace => no,
    ensure => present,
    source => 'puppet:///modules/redmine/database.yml',
  }

  apache::vhost { 'local.redmine.dev':
    port => '80',
    docroot => '/var/www/redmine/public',
  }
}
