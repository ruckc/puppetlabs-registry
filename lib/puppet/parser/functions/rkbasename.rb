#
# rkbasename.rb
#

module Puppet::Parser::Functions
  newfunction(:rkbasename, :type => :rvalue, :doc => <<-EOS
This function applies a rkbasename to all elements in an array.

*Examles:*

    rkbasename('HKU\.DEFAULT\Environment\TEST')

Will return: TEST 
    EOS
  ) do |arguments|

    # Technically we support two arguments but only first is mandatory ...
    raise(Puppet::ParseError, "rkbasename(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    path = arguments[0]

    unless path.is_a?(String)
      raise(Puppet::ParseError, 'rkbasename(): Requires string to work with')
    end

    return path.split(/\\/)[-1]
  end
end

# vim: set ts=2 sw=2 et :
