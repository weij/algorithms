
class MaxPQ
	
  # TODO: How to deal with various initialization options?	
  def initialize(maxN=2)
	@pq = Array.new(maxN+1)
    @size = 0
  end

  def isEmpty?
  	@size == 0
  end

  def size
  	@size
  end

  def insert(key)
  	@size +=1
  	@pq[@size] = key
    swim(@size)
  end
  
  def delMax
  	max = @pq[1] #Retrieve max key from top
  	@pq[1], @pq[@size] = @pq[@size], @pq[1] #Exchange with last item
  	@pq[@size] = nil  #avoid loitering
  	@size -=1 
  	sink(1) #Restore heap property
  	max
  end

  # TODO: how to deal with OutOfBound error?
  def swim(key)
  	while key > 1 and @pq[key/2] < @pq[key]
  	  @pq[key/2], @pq[key] = @pq[key], @pq[key/2]
  	  key = key/2
  	end
  end
  
  def sink(key)
    while 2*key <= @size
      child_key = 2*key
      child_key+=1 if child_key < @size and @pq[child_key] < @pq[child_key+1]
      break unless @pq[key] < @pq[child_key]
      @pq[key], @pq[child_key] = @pq[child_key], @pq[key]
      key = child_key
    end 	
  end 
end

require 'minitest/autorun'

class TestMaxpq < Minitest::Test

  def setup
    @maxpq = MaxPQ.new	
  end

  def test_swim_when_only_one_key_exist
    @maxpq.instance_variable_set(:@pq, [nil,'T'])
    @maxpq.instance_variable_set(:@size, 1)
    refute @maxpq.swim(1), "Refute to kick of swim operation"
  end 

  def test_swim_when_parent_node_less_than_child_key
  	@maxpq.instance_variable_set(:@pq, [nil, 'S', 'P', 'R', 'G', 'T'])
  	@maxpq.swim(5)
  	assert_equal [nil, 'T', 'S', 'R', 'G', 'P'], @maxpq.instance_variable_get(:@pq)
  end
  
  def test_sink_when_child_node_greater_than_parent_key
  	@maxpq.instance_variable_set(:@pq, [nil, 'H', 'S', 'R', 'P', 'N'])
  	@maxpq.instance_variable_set(:@size, 5)
  	@maxpq.sink(1)
  	assert_equal [nil, 'S', 'P', 'R', 'H', 'N'], @maxpq.instance_variable_get(:@pq)
  end

  def test_remove_the_maximum
  	before_del_max = [nil, 'T', 'S', 'R', 'P', 'N', 'O', 'A', 'E', 'I', 'G', 'H']
  	after_del_max  = [nil, 'S', 'P', 'R', 'I', 'N', 'O', 'A', 'E', 'H', 'G', nil] 
    @maxpq.instance_variable_set(:@pq, before_del_max)
    @maxpq.instance_variable_set(:@size, 11)

    @maxpq.delMax
    assert_equal after_del_max, @maxpq.instance_variable_get(:@pq)
    assert_equal 10, @maxpq.size
  end

  def test_insert_operation
  	pq = MaxPQ.new(5)
  	assert pq.isEmpty?
    ['S', 'P', 'R', 'G', 'T'].each {|key| pq.insert key; puts pq.inspect}
    assert_equal [nil, 'T', 'S', 'R', 'G', 'P'], pq.instance_variable_get(:@pq)
  	assert_equal 5, pq.size
  end 

  def test_remove_the_maximum_operation
  	
  end
end