require 'timeout'

def swap(array, index1, index2)
  temp = array[index2]
  array[index2] = array[index1]
  array[index1] = temp
end

def merge(a, b)
  result = []

  while a.size > 0 && b.size > 0
    if a[0] < b[0]
      result << a.shift
    else
      result << b.shift
    end
  end

  result + a + b
end

def mergesort(array)
  n = array.size

  return array if n <= 1

  middle = n / 2

  left  = mergesort(array[0...middle])
  right = mergesort(array[middle...n])

  merge(left, right)
end

def test(array)
  Timeout.timeout(0.1) do
    print array.inspect
    print " => "

    builtin = array.sort
    tested = mergesort(array)

    puts (builtin == tested ? "\e[32m#{tested.inspect}\e[0m" : "\e[31m#{tested.inspect}\e[0m")
  end
end

test []
test [10]
test [1, 2, 3, 4, 5, 6]
test [6, 5, 4, 3, 2, 1]
test [6, 1, 3, 1, 1, 9]
test (1..20).to_a.shuffle
