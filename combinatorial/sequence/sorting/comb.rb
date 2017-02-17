require 'timeout'

# Comb sort is similar to bubble sort
# but it tries to eliminate turtles in the array.

# In bubble sort small elements at the end of the
# array - a.k.a. turtles - slow down sorting tremendously.
# To combat this, we increase the gap between elements that
# are compared in the algorithm.

# At the start the gap is is the whole array, and in each
# iteration we reduce the gap by a given factor.
# The creators of the algorithm got the best result by
# using 1.3 as the gap reduction factor.

# Worst case performance is still O(n^2), however the algorithm
# is faster than bubble sort and coctail sort on average.

def swap(array, index1, index2)
  temp = array[index2]
  array[index2] = array[index1]
  array[index1] = temp
end

def comb(array)
  n = array.length
  gap = n
  factor = 1.3

  swapped = false

  while gap > 1 || swapped
    # shrink gap size before each iteration
    gap = (gap / factor).floor

    # make sure that gap is not smaller than 1
    gap = [1, gap].max

    swapped = false

    (gap...n).step(gap).each do |index|
      if array[index - gap] > array[index]
        swap(array, index - gap, index)
        swapped = true
      end
    end
  end

  array
end

def test(array)
  Timeout.timeout(0.1) do
    print array.inspect
    print " => "

    builtin = array.sort
    tested = comb(array)

    puts (builtin == tested ? "\e[32m#{tested.inspect}\e[0m" : "\e[31m#{tested.inspect}\e[0m")
  end
end


test []
test [10]
test [1, 2, 3, 4, 5, 6]
test [6, 5, 4, 3, 2, 1]
test [6, 1, 3, 1, 1, 9]
