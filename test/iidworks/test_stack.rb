
require_relative '../../lib/iidworks/stacks'

require 'minitest/autorun'

module IIDWorks
  class TestStack < Minitest::Test
  
    def test_read_a_sequence
    	s = FixedCapacityStack.new(100)
  
    	%w{to be or not to - be - - that - - - is}.each do |item|
        if !(item == "-") 
          s.push(item)
    	  elsif !(s.isEmpty?)
    	    print "#{s.pop} "
        end 
      end
      assert_equal 2, s.size
    end
  
  
    def test_resize_when_capacity_reach_the_ceiling
      s = ResizingArrayStack.new(10)
      (0..10).each {|e| s.push(e)}
      assert_equal 20, s.entries.size
    end
  
    def test_resize_if_capacity_reach_one_quarter
      s1 = ResizingArrayStack.new(10)
      (1..9).each {|e| s1.push(e)}
      assert_equal 9, s1.size
      8.times {s1.pop }
      assert_equal 1, s1.size
      assert_equal 2, s1.entries.size
    end
  end
end