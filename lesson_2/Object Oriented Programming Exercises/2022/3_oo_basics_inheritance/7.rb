# Method Lookup (part 1)

# Using the following code, determine the lookup path used when invoking cat1.color. Only list the classes that were checked by Ruby when searching for the #color method.

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
cat1.color

# Cat
# Animal


# When a method is invoked, Ruby searches the method's class for the specified method. If no method is found, then Ruby inspects the class's superclass. This process is repeated until the method is found or there are no more classes.

# To find the lookup path for a class, simply invoke #ancestors on the class. This method returns an array containing the names of the classes in the lookup path, based on the order in which they're checked.


puts cat1.class.ancestors
