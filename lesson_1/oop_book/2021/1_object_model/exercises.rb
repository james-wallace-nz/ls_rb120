# 1. How do we create an object in Ruby? Give an example of the creation of an object.

# We instantiate an object (create an instance) in Ruby by calling the `new` class method on the class.

module Speak
  def speak(words)
    puts "#{words}"
  end
end

class Dog
  include Speak
end

ludo = Dog.new


# 2. What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.


# A module contains behaviours we can add to many classes by mixing it in / including (`include`) that module in with the classes.

# The purpose of a module is to abstract common behaviours across many classes to one place so we can write it once.

# We mix in a module using the `include` method invocation followed by the module name within the class we want to add it to.


ludo.speak('bark')


# a module allows us to group reusable code into one place.

# Module extends functionality of a class. We use modules by using the `include` method invocation followed by the module name. 

# Modules are also used as a namespace. This helps us organise our code better.

# E.g.

module Careers
  class Engineer
  end

  class Teacher
  end
end

first_job = Careers::Teeacher.new
