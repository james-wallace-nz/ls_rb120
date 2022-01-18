# Method Lookup (part 2)

# Using the following code, determine the lookup path used when invoking cat1.color. Only list the classes and modules that Ruby will check when searching for the #color method.

class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color

# Cat
# Animal
# Object
# Kernel
# BasicObject


# Nearly every class in Ruby inherits from another class. This is true until the class named BasicObject, which doesn't inherit from a class. Some classes also include modules, much as the Object class includes the Kernel module.
