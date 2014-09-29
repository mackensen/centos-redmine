node 'vcr' {
  class { 'mysql::server':
    root_password => 'password'
  }
  include redmine
}
