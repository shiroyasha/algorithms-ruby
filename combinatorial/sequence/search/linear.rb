def search(array, element)
  array.each do |el|
    return true if el == element
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
  printf "searching for %4d in %20s ", element, array

  result = search(array, element)

  printf " => %10s", (result ? "found" : "not found")

  if array.include?(element) == result
    puts green(" ---- correct result")
  else
    puts red(" ---- incorrect result")
  end
end

test [], 9
test [10], 10
test [10], 1
test [6, 1, 3, 1, 1, 9], 12
test [6, 1, 3, 1, 1, 9], -12
test [6, 1, 3, 1, 1, 9], 1
