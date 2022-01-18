# Generic Greeting (part 1)

# Modify the following code so that Hello! I'm a cat! is printed when Cat.generic_greeting is invoked.


class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

# Expected output:
# Hello! I'm a cat!


kitty = Cat.new
# kitty.generic_greeting 
# => undefined method `generic_greeting' for #<Cat:0x007fbdd3875e40> (NoMethodError)


# Further Exploration:

kitty.class.generic_greeting 

# What happens if you run kitty.class.generic_greeting? Can you explain this result?

# kitty is an instance of the Cat class
# Calling the `class` method on kitty object will return the class that it is an instance of, `Cat`. Therefore, we can then call the class method `generic_greeting` on the `Cat` class.
