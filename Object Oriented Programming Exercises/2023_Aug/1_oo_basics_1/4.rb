# Using the code from the previous exercise, add an #initialize method that prints I'm a cat! when a new Cat object is instantiated.

# Code:

class Cat
  def initialize
    puts "I'm a cat!"
  end
end

kitty = Cat.new

# Expected output:

# I'm a cat!

# When defining a class, you usually need to define the #initialize method. #initialize is useful for setting up -- initializing -- an object so the object is ready for immediate use.

# To add #initialize to Cat, define it with the reserved word def. Adding this method lets us execute certain statements when a new Cat object is initialized. In this case, we want to print I'm a cat!. We accomplish this by using #puts.
