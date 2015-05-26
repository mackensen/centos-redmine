class redmine (
  $version = '2.6-stable',
  $docroot = '/var/www/redmine',
) {
  class { 'redmine::install': }->
  class { 'redmine::config': }->
  class { 'redmine::database': }->
  class { 'redmine::rake': }->
  class { 'passenger': }
}
