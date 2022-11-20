# 1.

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

# A string 'You will ' followed by one of the three strings in the array returned by call to `choices` instance method



# 2.

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

# We are calling `predict_the_future` on an instance of the RoadTrip class. Using the method lookup path, the call to `choices` instance method will find one in the RoadTrip class. Therefore, the array returned by the RoadTrip#choices method will have `sample` called on it, and then be added to `'You will '`



# 3.

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

# We can call `ancestors` method on a class to see an array of classes and modules in the method lookup path

puts Orange.ancestors # Orange, Taste, Object, Kernel, BasicObject



# 4.

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
    puts "I am a #{@type} of Bees Wax"
    puts "I am a #{type} of Bees Wax"
  end
end

# solution:
# This is much cleaner, and it is standard practice to refer to instance variables inside the class without @ if the getter method is available.



# 5.

# There are a number of variables listed below. What are the different types and how do you know which is which?

# excited_dog = "excited dog"
# @excited_dog = "excited dog"
# @@excited_dog = "excited dog"

# excited_dog is a local variable. It has no @ symbols at the start of the name
# @excited_dog is an instance variable because it has one @ symbol at the start of its name
# @@excited_dog is a class variable because it has two @@ symbols at thte start of its name



# 6.

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

# self.manufacturer is a class method becuase the name is prefixed with `self`. This means it is called on the class not an instance of the class.

# We call the class method on the class like this: Television.manufacturer



# 7.

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

# The @@cats_count variable is a class method. In this case, it keeps track of how many instances of the Cat class have been instantiated. When a new instance is instantiated with Cat.new, the initialize method is invoked. This increments the value referenced by @@cats_count. We can verify this by creating new instances of the Cat class and calling the self.cats_count method to see the value incrementing.

puts Cat.cats_count # 0
tabby = Cat.new('tabby')
puts Cat.cats_count # 1
ginger = Cat.new('ginger')
puts Cat.cats_count # 2

# solution:
# Every time we create a cat using Cat.new("tabby") we will be creating a new instance of the class Cat. During the object creation process it will call the initialize method and here is where we increment the value of the @@cats_count variable.



# 8.

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



# 9.

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

# calling the `play` instance method on an instance of the Bingo class would follow the method lookup chain to find the first `play` method available. If we have a `play` method in the Bingo class then it is this method that will be called. Ruby doesn't need to look further up the inheritance chain to find any other `play` methods.

# solution:
# If we added a new method to the Bingo class as seen below, it will use that method instead of looking up the chain and finding the Game class's method. Because Ruby doesn't want to look all over the place, as soon as it finds a method that matches it uses that - so in this case it is really first come first served.



# 10.

# What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can.

# cleaner
# more robust
# represents hierarchies in the real world
# redues code requried

# solution:
# Because there are so many benefits to using OOP we will just summarize some of the major ones:

  # - Creating objects allows programmers to think more abstractly about the code they are writing.

  # - Objects are represented by nouns so are easier to conceptualize.

  # - It allows us to only expose functionality to the parts of code that need it, meaning namespace issues are much harder to come across.

  # - It allows us to easily give functionality to different parts of an application without duplication.

  # - We can build applications faster as we can reuse pre-written code.

  # - As the software becomes more complex this complexity can be more easily managed.
