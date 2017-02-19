require 'timeout'

def swap(array, index1, index2)
  temp = array[index2]
  array[index2] = array[index1]
  array[index1] = temp
end

# returns index of smallest element in subarray
def smallest(array, from_index, to_index)
  smallest_index= from_index

  (from_index...to_index).each do |index|
    if array[index] < array[smallest_index]
      smallest_index = index
    end
  end

  smallest_index
end

def selection(array)
  n = array.length

  (0...n).each do |index|
    smallest_index = smallest(array, index, n)

    swap(array, smallest_index, index)
  end

  array
end

def test(array)
  Timeout.timeout(0.1) do
    print array.inspect
    print " => "

    builtin = array.sort
    tested = selection(array)

    puts (builtin == tested ? "\e[32m#{tested.inspect}\e[0m" : "\e[31m#{tested.inspect}\e[0m")
  end
end


test []
test [10]
test [1, 2, 3, 4, 5, 6]
test [6, 5, 4, 3, 2, 1]
test [6, 1, 3, 1, 1, 9]
test (1..20).to_a.shuffle
