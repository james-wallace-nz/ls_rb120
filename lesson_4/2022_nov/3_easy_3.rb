# Question 1

# If we have this code:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# What happens in each of the following cases:

# case 1:
hello = Hello.new
hello.hi

# instance of Hello class
# hello instance calls `hi`, which calls `greet` in Greeting super-class
# outputs
# Hello
# => nil

# case 2:
hello = Hello.new
hello.bye

# NoMethodError - the `bye` instance method doesn't exist in Hello or the method inheritance hierarchy

# case 3:
hello = Hello.new
hello.greet

# ArgumentError (0 for 1) - the `greet` instance method requires one argument but zero are passed in on line `43`. `greet` can be called because `Greeting` is a super-class of `Hello`
# `Hello` class can access its parent class `greet` method

# case 4:
hello = Hello.new
hello.greet("Goodbye")

# output:
# Goodbye
# => nil

# case 5:
Hello.hi
# NoMethodError - no class method called `hi`.


# Question 2

# In the last # question we had the following classes:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# If we call Hello.hi we get an error message. How would you fix this?

# add the following method to the Hello class:
# def self.hi
#   greeting = Greeting.new
#   greeting.greet('Hello')
# end


# Question 3

# When objects are created they are a separate realization of a particular class.

# Given the class below, how do we create two different instances of this class with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

sharpie = AngryCat.new(3, 'Sharpie')
mack = AngryCat.new(5, 'Mack')

# When we create AngryCat objects we pass the constructor two values - an age and name
# These values are assigned to the new object's instance variables and each object ends up with different state

# By default, Ruby will call the `initialize` method on object creation


# Question 4

# Given the class below, if we created a new instance of the class and then called to_s on that instance we would get something like "#<Cat:0x007ff39b356d30>"

class Cat
  def initialize(type)
    @type = type
  end
end

# How could we go about changing the to_s output on this method to look like this: I am a tabby cat? (this is assuming that "tabby" is the type we passed in during initialization).

# add this instance method to the `Cat` class to override the `to_s` instance method
# attr_reader :type

# def to_s
#   "I am a #{type} cat"
# end


# Question 5

# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# What would happen if I called the methods like shown below?

tv = Television.new
tv.manufacturer
# => NoMethodError - no instance method `manufactuer`
# `tv` is an instance of the `Television` class and `manufacturer` is a class method, meaning it can only be called on the class itself

tv.model
# => method logic

Television.manufacturer
# => method logic

Television.model
# => NoMethodError - no class method `model`
# `model` method only exists on an instance of the class `Television`, `tv`.


# Question 6

# If we have a class such as the one below:

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# In the make_one_year_older method we have used self. What is another way we could write this method so we don't have to use the self prefix?

# def make_one_year_older
#   @age += 1
# end

# `self` references the setter method provided by `attr_accessor`. We can replace `self` with `@` to change the instance variable directly


# Question 7

# What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end
end

# @brightness and @color instance variables. These are set on object initialization but not used
# Wrong
# `return` is not needed on line 217
# attr_accessor is not used
