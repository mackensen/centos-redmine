#!/usr/bin/env bash
# Bootstrap environment
yum update
yum install -y puppet vim-common vim-enhanced vim-minimal rubygems ruby-devel

# Puppet modules
(puppet module list |grep puppetlabs-apache) || puppet module install puppetlabs-apache
(puppet module list |grep puppetlabs-mysql) || puppet module install puppetlabs-mysql
(puppet module list |grep puppetlabs-passenger) || puppet module install puppetlabs-passenger
(puppet module list |grep puppetlabs-vcsrepo) || puppet module install puppetlabs-vcsrepo
(puppet module list |grep ploperations-bundler) || puppet module install ploperations-bundler
