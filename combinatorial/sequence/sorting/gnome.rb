require 'timeout'

# Gnome sort (or stupid sort as it was called by its creator)
# is similar to bubble sort.

# It finds the first pair of elements that are out of order
# and swaps backwards until the order is fixed.

# Worst case performance is O(n^2), but tends towards O(n)
# if the initial array is almost sorted.

def swap(array, index1, index2)
  temp = array[index2]
  array[index2] = array[index1]
  array[index1] = temp
end

def gnome(array)
  n = array.length
  pos = 0

  while pos < n
    if pos == 0 || array[pos] >= array[pos-1]
      pos = pos + 1
    else
      swap(array, pos, pos-1)
      pos = pos - 1
    end
  end

  array
end

def test(array)
  Timeout.timeout(0.1) do
    print array.inspect
    print " => "

    builtin = array.sort
    tested = gnome(array)

    puts (builtin == tested ? "\e[32m#{tested.inspect}\e[0m" : "\e[31m#{tested.inspect}\e[0m")
  end
end


test []
test [10]
test [1, 2, 3, 4, 5, 6]
test [6, 5, 4, 3, 2, 1]
test [6, 1, 3, 1, 1, 9]
test (1..20).to_a.shuffle
