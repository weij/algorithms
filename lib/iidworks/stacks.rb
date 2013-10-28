module IIDWorks  
  class FixedCapacityStack
    attr_reader :entries, :size
  
    def initialize(cap)
    	@entries = Array.new(cap)
    	@size = 0
    end
  
    def push(item)
    	@size += 1
    	@entries[@size] = item
    end
  
    def pop
    	@size -= 1 
    	entries[@size+1]
    end
  
    def isEmpty?
    	size == 0
    end
  end

  class ResizingArrayStack
    attr_reader :entries, :size

    def initialize(cap)
      @entries = Array.new(cap)
      @size = 0 
    end

    def push(item)
      resize(2* entries.size) if @size == entries.size
      @entries[@size] = item
      @size += 1
      entries
    end

    def pop
        @size -= 1 
        item = @entries[@size]
        @entries[@size] = nil
        resize(entries.size/4) if @size > 0 and @size == entries.size/4
        item
    end
  
    def isEmpty?
        size == 0
    end

  private

    def resize(max)
      temp = Array.new(max)
      # puts size
      for i in 0...size do
        temp[i] = @entries[i]
      end
      @entries = temp
    end  
  end
end  