#
# expand_hku.rb
#

module Puppet::Parser::Functions
  newfunction(:expand_hku, :type => :rvalue, :doc => <<-EOS
This function applies a expand_hku to all elements in an array.

*Examles:*

    expand_hku('p',['a','b','c'])

Will return: ['pa','pb','pc']
    EOS
  ) do |arguments|

    # Technically we support two arguments but only first is mandatory ...
    raise(Puppet::ParseError, "expand_hku(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    path = arguments[0]
    array = arguments[1]
    puts array.class
    unless array.is_a?(Array)
      raise(Puppet::ParseError, "expand_hku(): Requires array to work with (got #{array.class})")
    end

    unless path.is_a?(String)
      raise(Puppet::ParseError, 'expand_hku(): Requires string to work with')
    end

    # Turn everything into string same as join would do ...
    result = array.collect do |i|
      "HKU\\#{i}\\#{path}"
    end

    return result
  end
end

# vim: set ts=2 sw=2 et :
