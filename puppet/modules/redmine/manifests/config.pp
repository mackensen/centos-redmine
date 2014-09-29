class redmine::config {
  file { "${redmine::docroot}/config/database.yml":
    replace => no,
    ensure => present,
    source => 'puppet:///modules/redmine/database.yml',
  }

  apache::vhost { 'local.redmine.dev':
    port => '80',
    docroot => "${redmine::docroot}/public",
  }
}
