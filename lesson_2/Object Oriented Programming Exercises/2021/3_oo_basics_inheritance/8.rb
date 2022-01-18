class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color

# Cat, Animal, Object, Kernel, BasicObject
# Object class inherits from the Kernel module
# BasicObject class doesn't have a super class
