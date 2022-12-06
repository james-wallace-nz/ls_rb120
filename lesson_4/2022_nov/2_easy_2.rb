# Question 1

# You are given the following code:

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

# What is the result of executing the following code:

oracle = Oracle.new
oracle.predict_the_future
# => 'You will eat a nice lunch'
# => 'You will take a nap soon'
# => 'You will stay at work late'


# Question 2

# We have an Oracle class and a RoadTrip class that inherits from the Oracle class.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# What is the result of the following:

trip = RoadTrip.new
trip.predict_the_future

# => 'You will visit Vegas'
# => 'You will fly to Fiji'
# => 'You will romp in Rome'

# When `predict_the_future` is called on `trip`, an instance of the `RoadTrip` class, Ruby finds the method via inheritance hierarchy in the `Oracle` super-class.

# When `predict_the_future` in the `Oracle` class is executed it will execute the `choices` instance method in the RoadTrip class because we called `predict_the_future` on an instance of that class.

# Every time Ruby tries to resolve a method name it will start with the methods defined on the class you are calling.



# Question 3

# How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors?

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# What is the lookup chain for Orange and HotSauce?

# We can find an object's ancestors by calling `ancestors` class method on the object's  class.

puts Orange.ancestors
# Orange
# Taste
# Object
# Kernel
# BasicObject

puts HotSauce.ancestors
# HotSauce
# Taste
# Object
# Kernel
# BasicObject

# Ruby will look for a method starting in the first class in the method lookup chain.


# Question 4

# What could you add to this class to simplify it and remove two methods from the class definition while still maintaining the same functionality?

class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  # def type
  #   @type
  # end

  # def type=(t)
  #   @type = t
  # end

  def describe_type
    # puts "I am a #{@type} of Bees Wax"
    puts "I am a #{type} of Bees Wax"
  end
end

# We can replace the `type` and `type=` methods with attr_accessor. This will automatically create a getter and setter for `@type` instance variable

# As there is a method in the class which replaces the need to access the instance variable directly on line 120,  we can change the `describe_type` method to use the getter.



# Question 5

# There are a number of variables listed below. What are the different types and how do you know which is which?

# excited_dog = "excited dog"
# = local variable because it doesn't start with an @ symbol or a capital letter.

# @excited_dog = "excited dog"
# = instance method, becuase it starts with one @ symbol

# @@excited_dog = "excited dog"
# =class methods, because it starts with two @@ symbols


# Question 6

# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# Which one of these is a class method (if any) and how do you know? How would you call a class method?

# `self.manufacturer` is a class method because it starts with `self.` when defined within the class.
# We can call it on the class like this:
Television.manufacturer


# Question 7

# If we have a class such as the one below:

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Explain what the @@cats_count variable does and how it works. What code would you need to write to test your theory?

# The `@@cats_count` class variable tracks the number of `Cat` object instances created. When a new instance is instantiated with `Cat.new`, `@@cats_count` is incremented by `1`.

puts Cat.cats_count
# 0
# => nil

first = Cat.new('tabby')
puts Cat.cats_count
# 1
# => nil

second = Cat.new('black')
puts Cat.cats_count
# 2
# => nil

# During the object creation process it will call `initialize` method which increments `@@cats_count`



# Question 8

# If we have this class:

class Game
  def play
    "Start the game!"
  end
end

# And another class:

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# What can we add to the Bingo class to allow it to inherit the play method from the Game class?

# We can add:
# < Game
# so that `Bingo` is a sub-class of `Game` and inherits its methods


# Question 9

# If we have this class:

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# What would happen if we added a play method to the Bingo class, keeping in mind that there is already a method of this name in the Game class that the Bingo class inherits from.

# Adding a `play` instance method to the `Bingo` class will override the `play` method inherited from `Game`. When `play` is invoked on an instance of `Bingo`, Ruby will execute the `play` method from the `Bingo` class rather than the `Game` super-class.



# Question 10

# What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can.

# - encapsulate logic within classes and expose on the required interface to interact with objects of that class
# - can treat objects of different classes the same way if they expose the same method
# - allows us flexibility to inherit from super-classes and mix-in methods from modules, thereby keeing our code DRY and easier to maintain.

# - objects allows programmers to think more abstractly about the code
# - objects represented by nouns are easier to conceptualize
# - only expose functionality to parts of code that need it, reduces namespace issues
# - easily give functionality to different parts of an application without duplication
# - can buld applications faster and reuse pre-written code
# - as the software becomes more complex this complexity can be more easily managed
