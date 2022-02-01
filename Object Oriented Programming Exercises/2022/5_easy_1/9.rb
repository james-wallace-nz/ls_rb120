# Complete the Program - Cats!

# Consider the following program.

class Pet
  def initialize(name, age, colors)
    @name = name
    @age = age
    @colors = colors
  end
end

class Cat < Pet
  # def initialize(name, age, colors)
  #   super(name, age)
  #   @colors = colors
  # end

  def to_s
    "My cat #{@name} is #{@age} years old and has #{@colors} colors."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

# Update this code so that when you run it, you see the following output:

# My cat Pudding is 7 years old and has black and white colors.
# My cat Butterscotch is 10 years old and has tan and white colors.


# Further Exploration

# An alternative approach to this problem would be to modify the Pet class to accept a `colors` parameter. If we did this, we wouldn't need to supply an initialize method for Cat.

# Why would we be able to omit the initialize method? Would it be a good idea to modify Pet in this way? Why or why not? How might you deal with some of the problems, if any, that might arise from modifying Pet?


# We can omit the `initialize` method becuase of the method lookup hierarchy. If no `initialize` method exists in the `Cat` class then Ruby will look in any included modules and superclasses for an `initialize` method. The first one it finds in this case is the initialize method in the `Pet` superclass, so it will invoke that

# It makes sense to add a `@colorss` attribute to the `Pet` class if we expect all instances of the `Pet` class and any subclasses will have `@colors` instance variable. If not, then some `Pet` instance objects may have an unnecessary `@colors` instance variable. 
