require 'timeout'

def search(array, element)
  left = 0
  right = array.size

  while left < right
    middle = ((left+right)/2).floor

    value = array[middle]

    if value < element
      left = middle + 1
    elsif value > element
      right = middle - 1
    else
      return true
    end
  end

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
