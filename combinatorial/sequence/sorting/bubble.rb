def swap(array, index1, index2)
  temp = array[index2]
  array[index2] = array[index1]
  array[index1] = temp
end

def bubble(array)
  n = array.length

  begin
    swapped = false

    (1..n-1).each do |index|
      if array[index - 1] > array[index]
        swap(array, index - 1, index)
        swapped = true
      end
    end

    n = n - 1
  end while swapped

  array
end

def test(array)
  print array.inspect
  print " => "

  builtin = array.sort
  tested = bubble(array)

  puts (builtin == tested ? "\e[32m#{tested.inspect}\e[0m" : "\e[31m#{tested.inspect}\e[0m")
end


test []
test [10]
test [1, 2, 3, 4, 5, 6]
test [6, 5, 4, 3, 2, 1]
test [6, 1, 3, 1, 1, 9]
