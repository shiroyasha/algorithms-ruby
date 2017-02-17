require 'timeout'

# Quick sort is one of the most well known, and one of the
# fastest sorting algorithms.

# It works by first choosing a pivot element, and then moving
# everything that is bigger to the right, and everthing that
# is smaller than the pivot to the left. After the first pivoting,
# the process is recursively repeated on the left and right partition.

# Worst case performance is O(n^2) but only for rare edge cases.
# On average it works in O(n * log n) time.

def swap(array, index1, index2)
  temp = array[index2]
  array[index2] = array[index1]
  array[index1] = temp
end

def partition(array, first_index, last_index)
  i = first_index
  j = last_index

  # choose an element from the middle as the pivot
  pivot = array[((i+j)/2).floor]

  loop do
    # find the first element that is larger or equal then the pivot
    i += 1 while array[i] < pivot

    # find the last element that is smaller or equal then the pivot
    j -= 1 while array[j] > pivot

    if i < j
      swap(array, i, j)
      i += 1
      j -= 1
    else
      return j
    end
  end
end

def quick(array, first_index = nil, last_index = nil)
  first_index ||= 0
  last_index  ||= array.size - 1

  return array unless first_index < last_index

  pivot_index = partition(array, first_index, last_index)

  quick(array, first_index, pivot_index)
  quick(array, pivot_index + 1, last_index)

  array
end

def test(array)
  Timeout.timeout(0.1) do
    print array.inspect
    print " => "

    builtin = array.sort
    tested = quick(array)

    puts (builtin == tested ? "\e[32m#{tested.inspect}\e[0m" : "\e[31m#{tested.inspect}\e[0m")
  end
end


test []
test [10]
test [1, 2, 3, 4, 5, 6]
test [6, 5, 4, 3, 2, 1]
test [6, 1, 3, 1, 1, 9]
test (1..20).to_a.shuffle
