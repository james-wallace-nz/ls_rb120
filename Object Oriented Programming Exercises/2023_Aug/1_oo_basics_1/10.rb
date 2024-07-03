# Using the following code, create a module named Walkable that contains a method named #walk. This method should print Let's go for a walk! when invoked. Include Walkable in Cat and invoke #walk on kitty.

module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.walk

# Expected output:

# Hello! My name is Sophie!
# Let's go for a walk!

# Modules are typically used to contain methods that may be useful for multiple classes, but not all classes. When you mix a module into a class, you're allowing the class to invoke the contained methods.

# In our solution, we create a module named Walkable that contains a method named #walk. We give Cat access to this method by including Walkable in the class, like this:

module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  include Walkable
end

# This lets us invoke #walk on any instance of Cat. In this case, if we invoke kitty.walk, then Let's go for a walk! will be printed.