module IIDWorks
  module QuickSort
	def self.sort_internal(collection, lo, hi, cutoff: 5)
	  return insertion_sort(collection, lo, hi) if hi <= lo + cutoff
	  j = partition(collection, lo, hi)
      sort_internal(collection, lo, j-1)
      sort_internal(collection, j+1, hi)   
	end	

	def self.partition(collection, lo, hi)
      i, j = lo, hi+1
      v = collection[lo]
      loop do 
      	i += 1
      	while collection[i] < v 
          break if i == hi
          i += 1
      	end

      	j -= 1
      	while v < collection[j]
          break if j == lo
          j -= 1
      	end

      	# puts "#{i} >= #{j}" 
        break if i >= j
        # puts "From left (i): #{collection[i]} at #{i}; from right (j): #{collection[j]} at #{j}"
      	collection[i], collection[j] = collection[j], collection[i]
        # puts collection.to_s
      end

      # puts "#{collection[j]} at #{j} exchange with #{collection[lo]} at #{lo}"
      collection[lo], collection[j] = collection[j], collection[lo]
      # puts collection.to_s
      return j
	end

    def self.insertion_sort(collection, lo, hi)
      j = lo + 1
      while j <= hi
        
        key = collection[j]
        i = j-1
        while i >= lo and collection[i] > key
          collection[i+1] = collection[i]
          i -=1
          # iputs collection.inspect
        end
        collection[i+1] = key
        j +=1
      end
      collection
    end		
  end
end

require 'minitest/autorun'
require 'minitest/benchmark'

class TestQuickSort < Minitest::Test

  def test_3_parameters_insertion_sort
    @a = %w{S O R T E X A M P L E}    
    @sorted = %w{A E E L M O P R S T X}
    assert_equal @sorted, IIDWorks::QuickSort.insertion_sort(@a, 0, 10)      	
  end

  def test_cutoff_to_insertion_sort
  	quicksort_example = %w{Q U I C K S O R T E X A M P L E}
    sorted = %w{A C E E I K L M O P Q R S T U X} 
    assert_equal sorted, IIDWorks::QuickSort.sort_internal(quicksort_example, 0, 15)          
  end

end

class BenchQuickSort < Minitest::Benchmark

  def bench_cutoff_algorithm 
  	assert_performance_linear 0.99 do |n|
  	  a = Array.new(n) { rand }
  	  IIDWorks::QuickSort.sort_internal(a, 0, a.size-1)
    end

  	assert_performance_linear 0.99 do |n|
  	  a = Array.new(n) { rand }
  	  IIDWorks::QuickSort.sort_internal(a, 0, a.size-1, cutoff: 10)
    end    
  end 

end