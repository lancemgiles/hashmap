# represents the full list
class LinkedList
  attr_accessor :list, :nodes, :head
  def initialize
    @list = []
    @nodes = 0
    @head = nil
  end

  def append(value)
    # add new node containing value to the end of the list
    if @head.nil?
      @list << value
      @head = Node.new(value)
    else
      current = @head
      current.next_node = value
      @list << current.next_node
    end
    @nodes += 1
    @list
  end

  def prepend(value)
    # add new node containing value to the start of the list
    if @head.nil?
      @head = Node.new(value)
      @list << value
    else
      @list.unshift(value)
      @head.value = @list[0]
    end
    @nodes += 1
  end

  def size
    # returns the total number of nodes in the list
    @nodes
  end

  def head
    @head
  end

  def tail
    # returns the last node in the list
    @list[-1]
  end

  def at(index)
    # returns the node at the given index
    @list[index]
  end

  def pop
    # removes the last eleent from the list
    @list.pop
    @nodes -= 1
    @head
  end

  def contains?(val)
    # returns true if the passed in value is in the list and otherwise returns false
    @list.any?(val)
  end

  def find(val)
    # returns the index of the node containing value, or nil if not found
    @list.find_index(val)
  end

  def to_s
    # represent LinkedList objects as strings: ( value ) -> ( value ) -> ( value ) -> nil
    @list.each do |node|
      print "( #{node} ) -> "
    end
    p nil
  end
end

# represents each node of the list
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end