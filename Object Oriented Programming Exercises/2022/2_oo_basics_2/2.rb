# Hello, Chloe!

# Using the following code, add an instance method named #rename that renames kitty when invoked.


class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(new_name)
    self.name = new_name
  end
end

kitty = Cat.new('Sophie')
puts kitty.name
kitty.rename('Chloe')
puts kitty.name

# Expected output:
# Sophie
# Chloe


# Using a getter method, we can retrieve a value simply by invoking the method. To modify a value using a setter method, we need to add additional syntax. When invoking setter methods, they must be denoted with self. We're required to use self so that Ruby knows the difference between initializing a local variable and invoking a setter method.

# In the solution, #rename accepts one argument, which represents a new name. To rename kitty, we invoke the setter method for @name and pass new_name as an argument.
