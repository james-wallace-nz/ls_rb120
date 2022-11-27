# Consider the following program.

class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end

end

class Cat < Pet
  def initialize(name, age, colors)
    super(name, age)
    @colors = colors
  end

  def to_s
    "My cat #{@name} is #{@age} years old and has #{@color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

# Update this code so that when you run it, you see the following output:

# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.


# Further Exploration

# An alternative approach to this problem would be to modify the Pet class to accept a colors parameter. If we did this, we wouldn't need to supply an initialize method for Cat.

# Why would we be able to omit the initialize method? Would it be a good idea to modify Pet in this way? Why or why not? How might you deal with some of the problems, if any, that might arise from modifying Pet?

# We could omit the initialize method in the Cat class because Ruby will look up the inheritance hierachy and invoke the first super method it finds, which will be in the superclass Pet.

# If we modify Pet class by adding a colors instance variable, then any objects instantiated from the Pet class or sub-classes will also need to provide a colours argument. We could provide a default parameter so that Pet and other sub-classes can stll be instantiated without modifying the arguments they provide to initialize.
