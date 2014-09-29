node 'vcr' {
  class {'passenger': }
  class { 'mysql::server':
    root_password => 'password'
  }
  include redmine
}
