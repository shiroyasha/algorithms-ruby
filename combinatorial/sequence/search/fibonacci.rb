require 'timeout'

# Same thing as binary search but uses fibonacci numbers.
# This approach can be faster if access to data is not uniform
# i.e. it takes more time to load the end of the array into memory.
#
# prerequisite: array must be sorted
#
# Has complexity O(log n)

def search(array, element)
  fibs = [0, 1, 1]

  while fibs[2] < array.size
    fibs[0] = fibs[1]
    fibs[1] = fibs[2]
    fibs[2] = fibs[0] + fibs[2]
  end

  offset = 0

  while fibs[2] > 1
    index = [offset + fibs[0], array.size - 1].min
    value = array[index]

    if value < element
      # continue search right
      offset = index + 1

      # shift fibs right
      fibs[2] = fibs[1]
      fibs[1] = fibs[0]
      fibs[0] = fibs[2] - fibs[1]
    elsif value > element
      # continue search left

      fibs[2] = fibs[0]
      fibs[1] = fibs[1] - fibs[0]
      fibs[0] = fibs[2] - fibs[1]
    else
      # we have found the element
      return true
    end
  end

  # check last remaining element
  return true if array.size > 0 && array[offset] == element

  false
end

def red(text)
  "\e[31m#{text}\e[0m"
end

def green(text)
  "\e[32m#{text}\e[0m"
end

def test(array, element)
  Timeout.timeout(0.1) do
    printf "searching for %4d in %20s ", element, array

    result = search(array, element)

    printf " => %10s", (result ? "found" : "not found")

    if array.include?(element) == result
      puts green(" ---- correct result")
    else
      puts red(" ---- incorrect result")
    end
  end
end

# assumes sorted input

test [], 9
test [10], 10
test [10], 1
test [6, 1, 3, 1, 1, 9].sort, 12
test [6, 1, 3, 1, 1, 9].sort, -12
test [6, 1, 3, 1, 1, 9].sort, 1
test [6, 1, 3, 1, 1, 9].sort, 9

100.times do
  test 10.times.map { |_| rand(10) }.sort, rand(10)
end
