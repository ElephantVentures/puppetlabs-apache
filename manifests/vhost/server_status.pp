# Define apache::vhost::server-status
#
# Sets up a vhost which only allows access from the vhost_name with which it is defined (loopback access)
# specifically defined to make server-status available.
#
# Parameters:
# - $vhost_name - The name to use for the vhost, defaults to 127.0.0.1
# - $port - The port on which the vhost will respond, defaults to 80
#
# Actions:
# * Install an Apache Virtual Host which is only accessible from it's own vhost_name which serves the server-status at /server-status
# 
# Requires:
# * mod_status, which is enabled by default
#
# Sample Usage:
# class { 'apache::vhost::server_status': }
#
class apache::vhost::server_status (
  $vhost_name = '127.0.0.1',
  $port       = 80,
  $template   = 'apache/vhost-server-status.conf.erb',
) {
  include apache

  # Template uses:
  # - $vhost_name
  # - $port
  file { "server_status.conf":
    path => "${apache::params::vdir}/server_status.conf",
    content => template($template),
    owner => 'root',
    group => 'root',
    mode => '0755',
    require => Package['httpd'],
    notify => Service['httpd'],
  }
}
  
  
