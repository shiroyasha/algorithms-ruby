require 'timeout'

# Cocktail shaker sort is similar to bubble sort
# but it tries to eliminate turtles in the array.

# In bubble sort small elements at the end of the
# array - a.k.a. turtles - slow down sorting tremendously.
# To combat this, we implement a bidirectional bubble sort
# to push small elements from the end of the array to
# the beggining of the array in early iterations.

# Worst case performance is still O(n^2), however the algorithm
# is faster than bubble sort on average.

def swap(array, index1, index2)
  temp = array[index2]
  array[index2] = array[index1]
  array[index1] = temp
end

def cocktail(array)
  n = array.length

  up_limit   = n-1
  down_limit = 1

  begin
    swapped = false

    # bubble biggest element to the end of array

    (0...up_limit).each do |index|
      if array[index] > array[index + 1]
        swap(array, index, index + 1)
        swapped = true
      end
    end

    up_limit -= 1

    return array unless swapped

    # bubble smallest element to the beggining of the array

    (down_limit...up_limit).reverse_each do |index|
      if array[index] < array[index - 1]
        swap(array, index, index - 1)
        swapped = true
      end
    end

    down_limit += 1

  end while swapped

  array
end

def test(array)
  Timeout.timeout(1) do
    print array.inspect
    print " => "

    builtin = array.sort
    tested = cocktail(array)

    puts (builtin == tested ? "\e[32m#{tested.inspect}\e[0m" : "\e[31m#{tested.inspect}\e[0m")
  end
end


test []
test [10]
test [1, 2, 3, 4, 5, 6]
test [6, 5, 4, 3, 2, 1]
test [6, 1, 3, 1, 1, 9]
