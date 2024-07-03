# Using the code from the previous exercise, replace the getter and setter methods using Ruby shorthand.

# Code:

class Cat
  # attr_reader :name
  # attr_writer :name
  attr_accessor :name

  def initialize(name)
    @name = name
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

# Using either attr_reader or attr_writer to create getter and setter methods is convenient when you only want to get or set a value. What if you want to do both? Ruby has a shorthand way of automatically creating both getter and setter methods using the attr_accessor method.

# Using attr_accessor is convenient with an instance variable like @name because we want to both retrieve the name and change it. As you saw in the previous exercise, attr_reader and attr_writer let us do both of those things. attr_accessor is just a simpler way of creating both of those methods.
