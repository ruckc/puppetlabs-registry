#
# rkdirname.rb
#

module Puppet::Parser::Functions
  newfunction(:rkdirname, :type => :rvalue, :doc => <<-EOS
This function applies a rkdirname to all elements in an array.

*Examles:*

    rkdirname('HKU\.DEFAULT\Environment\TEST')

Will return: HKU\.DEFAULT\Environment
    EOS
  ) do |arguments|

    # Technically we support two arguments but only first is mandatory ...
    raise(Puppet::ParseError, "rkdirname(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    path = arguments[0]

    unless path.is_a?(String)
      raise(Puppet::ParseError, 'rkdirname(): Requires string to work with')
    end
    path=path.split(/\\/)
    return path[0...path.length-1].join('\\')
  end
end

# vim: set ts=2 sw=2 et :
