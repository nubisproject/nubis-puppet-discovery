# == Class: nubis_discovery
#
# Full description of class nubis_discovery here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'nubis_discovery':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class nubis_discovery {
}

define nubis::discovery::service(
  $check = undef,
  $tcp = undef,
  $http = undef,
  $interval = "60s",
  $port = undef,
  $tags = [],
) {

  if $tags {
    validate_array($tags)
  }

  if (!$tcp and !$check and !$http) {
    fail("One of tcp,check,http must be set")
  }

  if (($tcp and $check) or ($tcp and $http) or ($check and $http))  {
    fail("Only one of tcp,check,http can be set")
  }

  if ($port) {
    validate_numeric($port)
  }

  $all_tags = unique(concat($tags, "%%PROJECT%%","%%ENVIRONMENT%%"))

  file { "/etc/consul/svc-$name.json":
    ensure => present,
    owner => "root",
    content => template("nubis_discovery/service.json.erb")
  }
}

define nubis::discovery::check(
  $check,
  $interval,
) {

  file { "/etc/consul/chk-$name.json":
    ensure => present,
    owner => "root",
    content => template("nubis_discovery/check.json.erb")
  }
}
