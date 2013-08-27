
module Selection

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

  def self.isSorted?(collection)
    collection.each_index do |i|
      return false if (i+1 < collection.size) and collection[i] > collection[i+1]
    end
    return true
  end
end


require 'minitest/autorun'

class TestSelection < Minitest::Test

  def setup
    @a = %w{S O R T E X A M P L E}    
  end

  def test_sort_class_method
    sorted_a = %w{A E E L M O P R S T X}
    assert_equal sorted_a, Selection.sort(@a)
  end

  def test_isSorted_class_method
    sorted = %w{A E E L M O P R S T X}
    refute Selection.isSorted?(@a), "given array should be unsorted"
    assert Selection.isSorted?(sorted), "given array should be sorted"
  end
end