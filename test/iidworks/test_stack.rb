
require_relative '../../lib/iidworks/stacks'

require 'minitest/autorun'

class TestStack < Minitest::Test

  def test_read_a_sequence
  	s = IIDWorks::FixedCapacityStack.new(100)

  	%w{to be or not to - be - - that - - - is}.each do |item|
      if !(item == "-") 
        s.push(item)
  	  elsif !(s.isEmpty?)
  	    print "#{s.pop} "
      end 
    end
    assert_equal 2, s.size
  end

end