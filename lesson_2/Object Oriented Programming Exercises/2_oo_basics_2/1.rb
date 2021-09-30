# Modify the following code so that Hello! I'm a cat! is printed when Cat.generic_greeting is invoked.

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

# Expected output:

# Hello! I'm a cat!

# What happens if you run kitty.class.generic_greeting? Can you explain this result?

kitty = Cat.new
kitty.class.generic_greeting
# => "Hello! I'm a cat!"

# `kitty.class` returns the class that the `kitty` object is an instance of, which is `Cat` class. We can then call the class method `generic_greeting` on the `Cat` string returned by the `class` method.