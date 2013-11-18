require 'minitest/autorun'

describe 'Ruby Block' do

  before do
  	class BlockExample
  	  CONST = 0
  	  @@a = 3

  	  def return_closure
        a = 1
        @a = 2
        -> { [CONST, a, @a, @@a, yield]}
  	  end
  	  def change_values
  	  	@a += 1
  	  	@@a += 1
  	  end

  	  def fib_up_to(max)
  	  	fib_numbers = []
  	  	i1, i2 = 1, 1
  	  	while i1 <= max
  	  	  fib_numbers << i1
          yield i1
          i1, i2 = i2, i1 + i2
  	  	end
  	  	return fib_numbers
  	  end
  	end
  end
  
  it 'should remember the context which it was defined' do

  	eg = BlockExample.new
  	block = eg.return_closure { "origin"}
  	block.call.must_equal [0,1,2,3, "origin"]
  	eg.change_values
  	block.call.must_equal [0,1,3,4,"origin"]
  end
  
  it 'should not overwrite the sorrounding variable with the same name block-local variable' do
  	value = 'some shape'
  	[1,2].each {|value| value -= value}
  	value.must_equal 'some shape'
  end

  it 'should not overwrite the sorrounding variable with the clearly defined block-local variable' do
  	square = "some shape"
  	sum = 0
  	[1,2,3,4].each do |value; square|
      square = value * value
      sum += square
  	end

  	sum.must_equal 30
  	square.must_equal 'some shape'
  end

  it 'accept variables passed into block' do
  	eg = BlockExample.new
  	eg.fib_up_to(5) { |f| print f}.must_equal [1,1,2,3,5]
  end
end