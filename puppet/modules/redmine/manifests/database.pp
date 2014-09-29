class redmine::database {
  mysql::db { 'redmine':
    user => 'redmine',
    password => 'password',
    host => 'localhost',
    grant => ['all'],
    charset => 'utf8',
  }
}
