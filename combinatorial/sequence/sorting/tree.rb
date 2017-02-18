require 'timeout'

# Simple idea. Create a binary serach tree and traverse 'in order'.

class BinarySearchTree
  attr_accessor :value
  attr_accessor :left
  attr_accessor :right

  def insert(element)
    if value.nil?
      @value = element
    elsif value > element
      @left = BinarySearchTree.new if left.nil?

      @left.insert(element)
    else
      @right = BinarySearchTree.new if right.nil?

      @right.insert(element)
    end
  end

  def in_order_traverse
    return [] if value.nil?

    l = left ? left.in_order_traverse : []
    r = right ? right.in_order_traverse : []

    l + [value] + r
  end

  def to_s(depth = 0)
    return "empty\n" if value.nil?

    result = "#{" " * depth * 2}- #{value}\n"

    if left
      result += left.to_s(depth + 1)
    end

    if right
      result += right.to_s(depth + 1)
    end

    result
  end
end

def tree_sort(array)
  tree = BinarySearchTree.new

  array.each { |el| tree.insert(el) }

  tree.in_order_traverse
end

def test(array)
  Timeout.timeout(0.1) do
    print array.inspect
    print " => "

    builtin = array.sort
    tested = tree_sort(array)

    puts (builtin == tested ? "\e[32m#{tested.inspect}\e[0m" : "\e[31m#{tested.inspect}\e[0m")
  end
end


test []
test [10]
test [1, 2, 3, 4, 5, 6]
test [6, 5, 4, 3, 2, 1]
test [6, 1, 3, 1, 1, 9]
test (1..20).to_a.shuffle
