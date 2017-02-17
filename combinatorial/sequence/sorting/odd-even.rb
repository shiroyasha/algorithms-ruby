require 'timeout'

# Odd even sort (or brick sort) sort is a variation of bubble sort.
# It works similarly as bubble sort, but # jumps two elements
# instead of one. First on odd indexes, then on even indexes.
#
# Worst case performance is still O(n^2).

def swap(array, index1, index2)
  temp = array[index2]
  array[index2] = array[index1]
  array[index1] = temp
end

def odd_even(array)
  n = array.length
  gap = n

  swapped = false

  begin
    swapped = false

    # something like "bubble sort" on odd indexes
    (1...n).step(2).each do |index|
      if array[index] < array[index - 1]
        swap(array, index, index - 1)
        swapped = true
      end
    end

    # something like "bubble sort" on even indexes
    (2...n).step(2).each do |index|
      if array[index] < array[index - 1]
        swap(array, index, index - 1)
        swapped = true
      end
    end
  end while swapped

  array
end

def test(array)
  Timeout.timeout(0.1) do
    print array.inspect
    print " => "

    builtin = array.sort
    tested = odd_even(array)

    puts (builtin == tested ? "\e[32m#{tested.inspect}\e[0m" : "\e[31m#{tested.inspect}\e[0m")
  end
end


test []
test [10]
test [1, 2, 3, 4, 5, 6]
test [6, 5, 4, 3, 2, 1]
test [6, 1, 3, 1, 1, 9]
