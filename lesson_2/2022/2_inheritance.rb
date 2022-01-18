# Class based inheritance works great when it's used to model hierarchical domains. 

# 1. Given this class:

# class Dog
#   def speak
#     'bark!'
#   end

#   def swim
#     'swimming!'
#   end
# end

# teddy = Dog.new
# puts teddy.speak           # => "bark!"
# puts teddy.swim            # => "swimming!"

# One problem is that we need to keep track of different breeds of dogs, since they have slightly different behaviors. For example, bulldogs can't swim, but all other dogs can.

# Create a sub-class from Dog called Bulldog overriding the swim method to return "can't swim!"

# class Bulldog < Dog
#   def swim
#     "Can't swim!"
#   end
# end

# bruce = Bulldog.new
# puts bruce.speak
# puts bruce.swim


# 2. Let's create a few more methods for our Dog class.

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

class Cat < Pet
  def speak
    'Meow!'
  end
end

kitty = Cat.new
puts kitty.speak
puts kitty.run
puts kitty.jump
# puts kitty.swim
# puts kitty.fecth


bruce = Dog.new
puts bruce.speak
puts bruce.run
puts bruce.jump
puts bruce.swim
puts bruce.fetch

# Create a new class called Cat, which can do everything a dog can, except swim or fetch. Assume the methods do the exact same thing. Hint: don't just copy and paste all methods in Dog into Cat; try to come up with some class hierarchy.




# 3. Draw a class hierarchy diagram of the classes from step #2

                Pet (run, jump)
                 |
          __________________   
         |                 |
        Cat (speak)       Dog (speak, swim, fetch)
                           |
                        Bulldog (swim)


# 4. What is the method lookup path and how is it important?

# The method lookup path is the chain of classes and modules that Ruby follows to find a method being called. Ruby will first look in the class of the object for that method. If it doesn't find it, Ruby will look in any modules included by that class (in reverse order). Then it will look in the super class for the method. It will continue all the way to BasicObject class if it can't find that method. If the method is found in that chain it will be invoked.


# The method lookup path is the order in which Ruby will traverse the class hierarchy to look for methods to invoke. 

# To see the method lookup path, we can use the .ancestors class method.

Bulldog.ancestors       # => [Bulldog, Dog, Pet, Object, Kernel, BasicObject]

# Note that this method returns an array, and that all classes sub-class from Object. Don't worry about Kernel or BasicObject for now.
