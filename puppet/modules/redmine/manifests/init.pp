class redmine (
  
) {
  class { 'redmine::install': }->
  class { 'redmine::config': }->
  class { 'redmine::database': }->
  class { 'redmine::rake': }->
  class { 'passenger': }
}
