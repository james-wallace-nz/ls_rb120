# Circular Queue

# A circular queue is a collection of objects stored in a buffer that is treated as though it is connected end-to-end in a circle. When an object is added to this circular queue, it is added to the position that immediately follows the most recently added object, while removing an object always removes the object that has been in the queue the longest.

# This works as long as there are empty spots in the buffer. If the buffer becomes full, adding a new object to the queue requires getting rid of an existing object; with a circular queue, the object that has been in the queue the longest is discarded and replaced by the new object.

# Assuming we have a circular queue with room for 3 objects, the circular queue looks and acts like this:

#   P1    P2    P3    Comments
#                     All positions are initially empty
#   1                 Add 1 to the queue
#   1     2           Add 2 to the queue
#   2                 Remove oldest item from the queue (1)
#   2     3           Add 3 to the queue
#   4     2     3     Add 4 to the queue, queue is now full
#   4           3     Remove oldest item from the queue (2)
#   4     5     3     Add 5 to the queue, queue is full again
#   4     5     6     Add 6 to the queue, replaces oldest element (3)
#   7     5     6     Add 7 to the queue, replaces oldest element (4)
#   7           6     Remove oldest item from the queue (5)
#   7                 Remove oldest item from the queue (6)
#                     Remove oldest item from the queue (7)
#                     Remove non-existent item from the queue (nil)

# Your task is to write a CircularQueue class that implements a circular queue for arbitrary objects. The class should obtain the buffer size with an argument provided to `CircularQueue::new`, and should provide the following methods:

# `enqueue` to add an object to the queue
# `dequeue` to remove (and return) the oldest object in the queue. It should return `nil` if the queue is empty.

# You may assume that none of the values stored in the queue are `nil` (however, `nil` may be used to designate empty spots in the buffer).

# [3, 2, 1]
# enqueue:
#   less than buffer size: add element to beginning of queue
#   full: pop last element and add new element to

# dequeue:
#   pop last element

class CircularQueue
  attr_reader :buffer

  def initialize(buffer_size)
    @buffer_size = buffer_size
    @buffer = []
  end

  # add object to the queue
  def enqueue(element)
    dequeue if @buffer.size == @buffer_size
    @buffer.unshift(element)
  end

  # remove (and return) oldest object.
  # return nil if queue is empty
  def dequeue
    @buffer.pop
  end

  # private

  # def size
  #   @buffer.size
  # end

  # def pop
  #   @buffer.pop
  # end

  # def unshift(element)
  #   @buffer.unshift(element)
  # end
end


# Solution

# class CircularQueue
#   attr_reader :buffer

#   def initialize(size)
#     @buffer = [nil] * size
#     @next_position = 0
#     @oldest_position = 0
#   end

#   def enqueue(object)
#     unless @buffer[@next_position].nil?
#       @oldest_position = increment(@next_position)
#     end

#     @buffer[@next_position] = object
#     @next_position = increment(@next_position)
#   end

#   def dequeue
#     value = @buffer[@oldest_position]
#     @buffer[@oldest_position] = nil
#     @oldest_position = increment(@oldest_position) unless value.nil?
#     value
#   end

#   private

#   def increment(position)
#     (position + 1) % @buffer.size
#   end
# end

# Examples:

queue = CircularQueue.new(3)
p queue.buffer
puts queue.dequeue == nil
p queue.buffer

queue.enqueue(1)
p queue.buffer
queue.enqueue(2)
p queue.buffer
puts queue.dequeue == 1
p queue.buffer

queue.enqueue(3)
p queue.buffer
queue.enqueue(4)
p queue.buffer
puts queue.dequeue == 2
p queue.buffer

queue.enqueue(5)
p queue.buffer
queue.enqueue(6)
p queue.buffer
queue.enqueue(7)
p queue.buffer
puts queue.dequeue == 5
p queue.buffer
puts queue.dequeue == 6
p queue.buffer
puts queue.dequeue == 7
p queue.buffer
puts queue.dequeue == nil
p queue.buffer

queue = CircularQueue.new(4)
p queue.buffer
puts queue.dequeue == nil
p queue.buffer

queue.enqueue(1)
p queue.buffer
queue.enqueue(2)
p queue.buffer
puts queue.dequeue == 1
p queue.buffer

queue.enqueue(3)
p queue.buffer
queue.enqueue(4)
p queue.buffer
puts queue.dequeue == 2
p queue.buffer

queue.enqueue(5)
p queue.buffer
queue.enqueue(6)
p queue.buffer
queue.enqueue(7)
p queue.buffer

puts queue.dequeue == 4
p queue.buffer
puts queue.dequeue == 5
p queue.buffer
puts queue.dequeue == 6
p queue.buffer
puts queue.dequeue == 7
p queue.buffer
puts queue.dequeue == nil
p queue.buffer
# The above code should display true 15 times.
