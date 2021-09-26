class Parent
  def say_hi
    p "Hi from Parent."
  end
end

puts Parent.superclass

class Child < Parent
  def say_hi
    p "Hi from Child."
  end

  # Overrides `Object` class `send` instance method.
  def send
    p "Send from Child..."
  end

  # Overrides `Object` class `instance_of?` instance method
  def instance_of?
    p "I am a fake instance"
  end
end

parent = Parent.new
parent.say_hi

child = Child.new
child.say_hi

# child.send :say_hi

# puts child.instance_of? Child
# puts child.instance_of? Parent
