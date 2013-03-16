# = Define: registry::value
#
# This defined resource type provides a higher level of abstraction on top of
# the registry_key and registry_value resources.  Using this defined resource
# type, you do not need to explicitly manage the parent key for a particular
# value.  Puppet will automatically manage the parent key for you.
#
# == Parameters:
#
# key:: The path of key the value will placed inside.
#
# value:: The name of the registry value to manage.  This will be copied from
#         the resource title if not specified.  The special value of
#         '(default)' may be used to manage the default value of the key.
#
# type:: The type the registry value.  Defaults to 'string'.  See the output of
#        `puppet describe registry_value` for a list of supported types in the
#        "type" parameter.
#
# data:: The data to place inside the registry value.
#
# == Actions:
#   - Manage the parent key if not already managed.
#   - Manage the value
#
# == Requires:
#   - Registry Module
#   - Stdlib Module
#
# == Sample Usage:
#
# This example will automatically manage the key.  It will also create a value
# named 'puppetmaster' inside this key.
#
#   class myapp {
#     registry::value { 'puppetmaster':
#       key => 'HKLM\Software\Vendor\PuppetLabs',
#       data => 'puppet.puppetlabs.com',
#     }
#   }
#
define registry::to_value($path=$title, $value=undef, $type='string', $data=undef,$ensure=present) {
  # validate our inputs.
  $pkey=rkdirname($path)
  $pvalue=rkbasename($path)

  validate_re($type, '^\w+', "type parameter must not be empty but it is type => '$type'")

  # If value_real is an empty string then the default value of the key will be
  # managed.
  registry::value { $path:
    ensure =>$ensure,
    key    =>$pkey,
    value  =>$pvalue,
    type   =>$type,
    data   =>$data,
  }
}
