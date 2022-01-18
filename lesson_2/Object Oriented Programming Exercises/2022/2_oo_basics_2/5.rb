# Counting Cats

# Using the following code, create a class named Cat that tracks the number of times a new Cat object is instantiated. The total number of Cat instances should be printed when ::total is invoked.

class Cat
  @@count = 0

  def initialize
    @@count += 1
  end

  def self.total
    puts @@count
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

Cat.total

# Expected output:
# 2

# Sometimes, certain data needs to be handled by the class itself, instead of instances of the class. That's where class variables come in. Class variables can be differentiated from instance variables by the double @@ prepended to their name.
