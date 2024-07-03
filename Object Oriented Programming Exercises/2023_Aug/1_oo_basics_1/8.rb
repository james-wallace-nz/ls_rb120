# Using the code from the previous exercise, add a setter method named #name=. Then, rename kitty to 'Luna' and invoke #greet again.

# Code:

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def name=(new_name)
    @name = new_name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.name = 'Luna'
kitty.greet

# Expected output:

# Hello! My name is Sophie!
# Hello! My name is Luna!

# Setter methods are created similarly to getter methods. Manually, they look the same except with an added = in the name and a parameter:

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def name=(name)
    @name = name
  end
end

# Using Ruby shorthand, setter methods are written like this:

class Cat
  attr_writer :name

  def initialize(name)
    @name = name
  end
end

# Like getter methods, setter methods can be invoked on the object. In this exercise, we use the setter method to rename kitty. If we invoke #greet on kitty, we'll see that change take effect:

kitty = Cat.new('Sophie')
kitty.greet # => Hello! My name is Sophie!
kitty.name = 'Luna'
kitty.greet # => Hello! My name is Luna!
