
require_relative '../../lib/iidworks/quicksort'
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