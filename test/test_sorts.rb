
module IIDWorks
  module InsertionSort
    def self.sort(collection, impl: :exchange_one_by_one)
      case :impl
      when :without_exchange
        return without_exchange(collection)
      else 
        return exchange_one_by_one(collection)
      end
    end
    
    # This impl moves larger elements to the right one position with one array access per entry,
    # rather than using exchange.
    # var i: indicates compare direction
    # var j: indicates scan direction
    def self.without_exchange(collection)
      size = collection.size
      j = 1
      while j < size
        
        key = collection[j]
        i = j-1
        while i >= 0 and collection[i] > key
          collection[i+1] = collection[i]
          i -=1
          # iputs collection.inspect
        end
        collection[i+1] = key
        j +=1
      end
      collection
    end

    # variable i: presents a pointer of sorted part, and scan direction
    # variable j: presents a pointer and direction of compare
    def self.exchange_one_by_one(collection)
      size = collection.size
      
      i = 1
      while i < size 
        j = i
        while j > 0 and collection[j] < collection[j-1]
          collection[j], collection[j-1] = collection[j-1], collection[j]
          j -= 1
          puts collection.inspect
        end
        i += 1
      end 
      collection
    end    
  end

  module SelectionSort
    # each_index(or variable i): presents a pointer/bound of sorted part
    # variable j: presents a pointer/direction of scan
    # variable min: presents a pointer of minimal element per scan
    def self.sort(collection)
  
      collection.each_index do |index|
        min = index #suppose index indicates the min element
        j = index + 1
  
        while j < collection.size do
          min = j if collection[j] < collection[min]
          j += 1
        end
  
        collection[index], collection[min] = collection[min], collection[index]
      end
  
      collection
    end
  end
  
  module ShellSort
    # variable h: increment sequence. (3^k-1)/2, for instance, 1, 4, 13, 40, 121, .. 
    # variable i: presents a pointer of sorted part, and scan direction. Always start at i = h
    # variable j: presents a pointer and direction of compare. Every comparing elements between h
    def self.sort(collection)
      size = collection.size
      h = 1
      while h <= size/3
        h = h*3+1
      end
  
      while h >= 1
  
        i = h     
        while i < size
  
          j = i
          while j >= h and (collection[j] < collection[j-h])
            collection[j], collection[j-h] = collection[j-h], collection[j]
            j -= h
          end
  
          i += 1
        end
  
        h = h/3
      end
  
      collection
    end     
  end

  module HeapSort 
    def self.sort(collection)
      size = collection.length-1
      key = size/2
      
      while key >= 1
        # puts "sink(#{key}, #{size})"
        sink(collection, key, size)
        key -=1
      end
  
      while size > 1
        collection[1], collection[size] = collection[size], collection[1]
        size -=1
        sink(collection, 1, size)
      end
  
      collection
    end
  
    def self.sink(collection, key, size)
      while 2*key <= size 
        j = 2*key
        j +=1 if j < size and collection[j] < collection[j+1]
        # puts collection.inspect
        break unless collection[key] < collection[j]
        collection[key], collection[j] = collection[j], collection[key]
        key = j
      end 
    end
  
    def self.isSorted?(collection)
      collection.each_index do |i|
        return false if (i+1 < collection.size) and collection[i] > collection[i+1]
      end
      return true
    end
  end 
end



require 'minitest/autorun'

class TestSorts < Minitest::Test

  def setup
    @a = %w{S O R T E X A M P L E}    
    @sorted = %w{A E E L M O P R S T X}
  end
   
  def test_heapsort
    @a.insert(0, nil)
    assert_equal @sorted.insert(0, nil), IIDWorks::HeapSort.sort(@a)
  end

  def test_selectionSort_class_method
    assert_equal @sorted, IIDWorks::SelectionSort.sort(@a)
  end

  def test_insertionSort_exchange_one_by_one_impl
    assert_equal @sorted, IIDWorks::InsertionSort.sort(@a)
  end

  def test_InsertionSort_without_exchange_impl
    assert_equal @sorted, IIDWorks::InsertionSort.sort(@a, impl: :without_exchange)
  end

  def test_isSorted_class_method
    refute IIDWorks::HeapSort.isSorted?(@a), "given array should be unsorted"
    assert IIDWorks::HeapSort.isSorted?(@sorted), "given array should be sorted"
  end

  def test_shellSort_class_method
    d = %w{S H E L L S O R T E X A M P L E}
    sorted = %w{A E E E H L L L M O P R S S T X}
    assert_equal sorted, IIDWorks::ShellSort.sort(d)
  end
end