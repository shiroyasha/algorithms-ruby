require 'timeout'

def swap(array, index1, index2)
  temp = array[index2]
  array[index2] = array[index1]
  array[index1] = temp
end

# we must pass 'heap_size' because we don't want to
# heapify the while array all the time
def heapify(array, heap_size, index)
  return if index >= heap_size

  l = index * 2 + 1
  r = index * 2 + 2

  largest = index

  largest = l if l < heap_size && array[l] > array[largest]
  largest = r if r < heap_size && array[r] > array[largest]

  if largest != index
    swap(array, index, largest)

    # propogate change on subtree
    heapify(array, heap_size, largest)
  end

  array
end

def draw(array, heap_size, root = 0)
  return if root >= heap_size

  depth = Math.log(root+1, 2).to_i

  puts ("-- " * depth) + array[root].to_s

  l = root * 2 + 1
  r = root * 2 + 2

  draw(array, heap_size, l)
  draw(array, heap_size, r)
end

def heapsort(array)
  heap_size  = array.size

  # rearange array into a heap starting from bottom
  (heap_size-1).downto(0).each do |index|
    heapify(array, heap_size, index)
  end

  while heap_size > 1
    heap_size -= 1

    swap(array, 0, heap_size)
    heapify(array, heap_size, 0)
  end

  array
end

def test(array)
  Timeout.timeout(0.1) do
    print array.inspect
    print " => "

    builtin = array.sort
    tested = heapsort(array)

    puts (builtin == tested ? "\e[32m#{tested.inspect}\e[0m" : "\e[31m#{tested.inspect}\e[0m")
  end
end


test []
test [10]
test [1, 2, 3, 4, 5, 6]
test [6, 5, 4, 3, 2, 1]
test [6, 1, 3, 1, 1, 9]
test (1..20).to_a.shuffle
