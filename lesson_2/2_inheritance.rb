# 1.

# One problem is that we need to keep track of different breeds of dogs, since they have slightly different behaviors. For example, bulldogs can't swim, but all other dogs can.

# Create a sub-class from Dog called Bulldog overriding the swim method to return "can't swim!"

# class Dog
#   def speak
#     'bark!'
#   end

#   def swim
#     'swimming!'
#   end
# end

# class Bulldog < Dog
#   def swim
#     "can't swim!"
#   end
# end

# teddy = Dog.new
# puts teddy.speak
# puts teddy.swim

# karl = Bulldog.new
# puts karl.speak
# puts karl.swim

# Note that since Bulldog objects are sub-classes of Dog objects, they can both override and inherit methods. That is why karl can speak.


# 2.

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

puts pete.run
# puts pete.speak

puts kitty.run
puts kitty.speak
# puts kitty.fetch

puts dave.speak

puts bud.run
puts bud.swim


# 3. Draw a class hierarchy diagram of the classes from step #2

#           Pet
#         - run
#         - jump


#     Dog         Cat
#   - speak     - speak
#   - fetch
#   - swim

#   Bulldog
# - swim


# 4.

# What is the method lookup path and how is it important?

# The method lookup path is the path that Ruby takes to find a method when it is called on an object.

# Ruby first looks in the object's class, then any included modules, then each of the object's superclasses in turn.

# The method lookup path is important because it determines which method definition is executed when a method is called, particularly if there are multiple methods called the same thing.

# - The order in which Ruby will traverse the class hierarchy to look for methods to invoke
# Ruby will invoke the first method in the chain that it finds then stop its traversal

