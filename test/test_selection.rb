
module Sorts

  def self.selectionSort(collection)

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

  def self.insertionSort(collection)
      size = collection.size
      
      i = 1
      while i < size 

        j = i
        while j > 0 and collection[j] < collection[j-1]
          collection[j], collection[j-1] = collection[j-1], collection[j]

          j -= 1
        end

        i += 1
      end 

      collection
  end

  def self.shellSort(collection)
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

  def self.isSorted?(collection)
    collection.each_index do |i|
      return false if (i+1 < collection.size) and collection[i] > collection[i+1]
    end
    return true
  end
end


require 'minitest/autorun'

class TestSorts < Minitest::Test

  def setup
    @a = %w{S O R T E X A M P L E}    
    @sorted = %w{A E E L M O P R S T X}
  end

  def test_selectionSort_class_method
    assert_equal @sorted, Sorts.selectionSort(@a)
  end

  def test_insertionSort_class_method
    assert_equal @sorted, Sorts.insertionSort(@a)
  end

  def test_isSorted_class_method
    refute Sorts.isSorted?(@a), "given array should be unsorted"
    assert Sorts.isSorted?(@sorted), "given array should be sorted"
  end

  def test_shellSort_class_method
    d = %w{S H E L L S O R T E X A M P L E}
    sorted = %w{A E E E H L L L M O P R S S T X}
    assert_equal sorted, Sorts.shellSort(d)
  end
end