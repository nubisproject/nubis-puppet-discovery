# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#

include nubis_discovery

nubis::discovery::service { 'test':
  tags => [ 'production','apache' ],
  port => 80,
  check => "wget http://localhost:80",
  interval => "30s",
}

nubis::discovery::check { 'ping':
  check => "ping -c1 google.com",
  interval => "10s",
}
