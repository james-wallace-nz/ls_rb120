class Parent
  def say_hi
    p 'Hi from Parent."'
  end
end

class Child < Parent
  def say_hi
    p 'Hi from Child.'
  end

  def send
    p 'send from Child.'
  end

  def instance_of?
    p "I'm a fake instance."
  end
end

child = Child.new
child.say_hi

son = Child.new
# son.send :say_hi
# Hi from Child.
# then: ArgumentError: wrong number of arguments (1 for 0)

son.send
# send from Child.

# c = Child.new
# puts c.instance_of? Child
# true
# puts c.instance_of? Parent
# false

c = Child.new
puts c.instance_of? Child
# ArgumentError: wrong number of arguments 1 for 0
puts c.instance_of? Parent
# false
