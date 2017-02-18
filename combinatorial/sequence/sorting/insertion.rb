require 'timeout'

def insertion(array)
  n = array.length

  (1...n).each do |index|
    element = array[index]

    j = index

    while j > 0 && array[j-1] > element
      array[j] = array[j-1]
      j -= 1
    end

    array[j] = element
  end

  array
end

def test(array)
  Timeout.timeout(0.1) do
    print array.inspect
    print " => "

    builtin = array.sort
    tested = insertion(array)

    puts (builtin == tested ? "\e[32m#{tested.inspect}\e[0m" : "\e[31m#{tested.inspect}\e[0m")
  end
end


test []
test [10]
test [1, 2, 3, 4, 5, 6]
test [6, 5, 4, 3, 2, 1]
test [6, 1, 3, 1, 1, 9]
test (1..20).to_a.shuffle
