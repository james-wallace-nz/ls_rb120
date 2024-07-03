# Using the code from the previous exercise, add a getter method named #name and invoke it in place of @name in #greet.

# Code:

class Cat
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet

# Expected output:

# Hello! My name is Sophie!

# Getter methods can be written one of two ways. They can be written manually, like this:

class Cat
  def initialize(name)
    @name = name
  end

  def name
    @name
  end
end

# They can also be written using Ruby shorthand, like this:

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

# Both of these code examples do the exact same thing, however, the second example is preferred due to its simplicity. A getter method not only lets us invoke #name inside the class, like this:

puts "Hello! My name is #{name}!"

# but it also lets us invoke #name outside the class via the object:

kitty.name # => Sophie