module IIDWorks  
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
end  