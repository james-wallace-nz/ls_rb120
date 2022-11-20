# 1.

# Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?

puts true.class
puts "hello".class
puts [1, 2, 3, "happy days"].class
puts 142.class

# All are objects:
# TrueClass
# String
# Array
# Integer

# We can call object.class to find out what class they belong to



# 2.

# If we have a Car class and a Truck class and we want to be able to go_fast, how can we add the ability for them to go_fast using the module Speed? How can you check if your Car or Truck can now go fast?

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

# We can include the Speed module in both the Car and Truck classes. We can then call the `go_fast` instance method on instances of the Car and Truck classes

mazda = Car.new
mazda.go_fast
mack = Truck.new
mack.go_fast



# 3.

# In the last question we had a module called Speed which contained a go_fast method. We included this module in the Car class as shown below.

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

# When we called the go_fast method from an instance of the Car class (as shown below) you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?

# >> small_car = Car.new
# >> small_car.go_fast
# I am a Car and going super fast!

# The go_fast method is called on an instance of the Car class. When called, `self.class` is interpolated into the string that is passed to `puts`. `self` in an instance method refers to the object that called the method. Therefore, `self` is 'small_car'. We then call `class` on the calling object, which returns the Car class that it is an instance of.

# solution:
# We use self.class in the method and this works the following way:

# self refers to the object itself, in this case either a Car or Truck object.
# We ask self to tell us its class with .class. It tells us.
# We don't need to use to_s here because it is inside of a string and is interpolated which means it will take care of the to_s for us.



# 4.

# If we have a class AngryCat how do we create a new instance of this class?

# The AngryCat class might look something like this:

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

# We can define a new instance of the AngryCat class like this:
pussy = AngryCat.new



# 5.

# Which of these two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# The Pizza class has an instance varibale, `@name`. This is because the variable name starts with one @ symbol. The Fruit class has a local variable called `name`.

# solution:
# hot_pizza = Pizza.new('cheese')
# orange = Fruit.new('apple')

# p hot_pizza.instance_variables # => [:@name]
# p orange.instance_variables # => []

#  if we call the instance_variables method on the instance of the class we will be informed if the object has any instance variables and what they are.



# 6.

# What could we add to the class below to access the instance variable @volume?

class Cube
  def initialize(volume)
    @volume = volume
  end
end

# We can add a getter method or use attr_reader / attr_accessor

# def volume
#   @volume
# end

# solution:
# Technically we don't need to add anything at all. We are able to access instance variables directly from the object by calling instance_variable_get on the instance. This would return something like this:

# >> big_cube = Cube.new(5000)
# >> big_cube.instance_variable_get("@volume")
# => 5000

# While this works it is generally not a good idea to access instance variables in this way.



# 7.

# What is the default return value of to_s when invoked on an object? Where could you go to find out if you want to be sure?

# The default return value of to_s is a string representing the object instance that it was invoked on. We can find this in the docs: https://ruby-doc.org/core-2.7.4/Object.html#method-i-to_s

# solution:
# By default, the to_s method will return the name of the object's class and an encoding of the object id.

# If you weren't sure of this answer you could of course refer to Launch School's Object Oriented Programming book, but you could also refer directly to the Ruby documentation, in this case, here: http://ruby-doc.org/core/Object.html#method-i-to_s.



# 8.

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

# You can see in the make_one_year_older method we have used self. What does self refer to here?

# `self` when used in an instance method refers to the instance object that called the method.

# solution:
# Firstly it is important to note that make_one_year_older is an instance method and can only be called on instances of the class Cat. Keeping this in mind the use of self here is referencing the instance (object) that called the method - the calling object.



# 9.

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

# In the name of the cats_count method we have used self. What does self refer to in this context?

# `self` when used in the class definition outside of an instance method refers to the class itself. This makes self.cats_count a class method.new

# solution:
# Because this is a class method it represents the class itself, in this case Cat. So you can call Cat.cats_count.



# 10.

# If we have the class below, what would you need to call to create a new instance of this class.

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

# We would need to call Bag.new but also pass in arguments for the `color` and `material` parameters in the `initialize` method.
bag = Bag.new('black', 'canvas')
p bag

# solution:
# As you can see from the initialize method, it is expecting two arguments. So as long as we pass in two arguments this error will go away - for example we could call this with Bag.new("green", "paper") and because this is providing the arguments that are needed it will successfully create the instance without an error.
