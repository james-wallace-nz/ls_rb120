# 1.

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

# hello = Hello.new
# hello.hi

# outputs 'Hello'


# case 2:

# hello = Hello.new
# hello.bye

# NoMethodError: undefined method `bye` for <object>


# case 3:

# hello = Hello.new
# hello.greet

# ArgumentError: given 0, expected 1


# case 4:

# hello = Hello.new
# hello.greet("Goodbye")

# outputs 'Goodbye'


# case 5:

# Hello.hi

# NoMethodError: undefined method `hi` in Hello class



# 2.

# In the last question we had the following classes:

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

# We can modify the hi method to be a class method, or we can add a hi class method. In both cases it would be:

# def self.hi
#   greeting = Greeting.new
#   greeting.greet('Hello')
# end

# solution:
# This is rather cumbersome. Note that we cannot simply call greet in the self.hi method definition because the Greeting class itself only defines greet on its instances, rather than on the Greeting class itself



# 3.

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

one = AngryCat.new(4, 'Mack')
two = AngryCat.new(2, 'Sharpy')

# solution:
# When we create the AngryCat objects, we pass the constructor two values -- an age and a name. These values are assigned to the new object's instance variables, and each object ends up with different information.

# To show this, lets create two cats.

# Copy Code
# henry = AngryCat.new(12, "Henry")
# alex   = AngryCat.new(8, "Alex")
# We now have two different instances of the AngryCat class.

# You will have noticed there is no new method inside of the AngryCat class, so how does Ruby know what to do when setting up the objects? By default, Ruby will call the initialize method on object creation.



# 4.

# Given the class below, if we created a new instance of the class and then called to_s on that instance we would get something like "#<Cat:0x007ff39b356d30>"

class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    'I am a #{@type} cat'
  end
end

# How could we go about changing the to_s output on this method to look like this: I am a tabby cat? (this is assuming that "tabby" is the type we passed in during initialization).

# solution:
# To do this we would need to override the existing to_s method by adding a method of the same name as this to the class. It would look something like this:

# We can customize existing methods like this easily, but in many cases it might be better to write a new method called something like display_type instead, as this is more specific about what we are actually wanting the result of the method to be.



# 5.

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
tv.manufacturer # NoMethodError, undefined method `manufacture` for <tv object>
tv.model # instance method would be invoked

Television.manufacturer # class method would be invoked
Television.model # NoMethodError, undefined method `model` for Television:Class



# 6.

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

# We could use `@age += 1`, but it is better to use the setter method

# solution:
# self in this case is referencing the setter method provided by attr_accessor - this means that we could replace self with @. So the revised method would look something like this:

# class Cat
#   attr_accessor :type, :age

#   def initialize(type)
#     @type = type
#     @age  = 0
#   end

#   def make_one_year_older
#     @age += 1
#   end
# end

# This means in this case self and @ are the same thing and can be used interchangeably.



# 7.

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

# We don't need the attr_accessor getter and setter methods for brightness and color

# solution:
# The answer here is the `return` in the information method. Ruby automatically returns the result of the last line of any method, so adding return to this line in the method does not add any value and so therefore should be avoided.

# We also never use the attr_accessor for brightness and color. Though, these methods do add potential value, as they give us the option to alter brightness and color outside the Light class.
