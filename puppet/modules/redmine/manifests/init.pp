class redmine (
  $version = '2.5.2',
  $docroot = '/var/www/redmine',
) {
  class { 'redmine::install': }->
  class { 'redmine::config': }->
  class { 'redmine::database': }->
  class { 'redmine::rake': }->
  class { 'passenger': }
}
