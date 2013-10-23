class FixedCapacityStack
  
  attr_reader :entries, :size

  def initialize(cap)
  	@entries = Array.new(cap)
  	@size = 0
  end

  def push(item)
  	@size += 1
  	entries[@size] = item
  end

  def pop
  	@size -= 1 
  	entries[@size+1]
  end

  def isEmpty?
  	size == 0
  end

end

require 'minitest/autorun'

class TestStack < Minitest::Test

  def test_read_a_sequence
  	s = FixedCapacityStackOfStrings.new(100)

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