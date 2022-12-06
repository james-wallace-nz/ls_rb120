# Question 1

# Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?

true                      # TrueClass

"hello"                   # String
[1, 2, 3, "happy days"]   # Array of Integers and String
142                       # Integer

puts true.class
puts "hello".class
puts [1, 2, 3, "happy days"].class
puts 142.class


# Question 2

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

# To provide the `go_fast` method to `Car` and `Truck` we `include` the `Speed` module in each class.

cx5 = Car.new
cx5.go_fast

mack = Truck.new
mack.go_fast


# Question 3

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

# When `go_fast` is invoked on an object instance of the `Car` class Ruby looks for that method name in that class. When it doesn't find it, Ruby looks for the method in the inheritance hierarcy, starting with the included Speed module. Finding `go_fast` in the `Speed` module, Ruby invokes that method.

# When called, the string that is output includes `self.class`. `self` refers to the object that invoked the method, which is the instance of Car. Invoking the `class` instance method on `self` returns the class that the object is an instance of, `Car`. This is interpolated into the string.


# Question 4

# If we have a class AngryCat how do we create a new instance of this class?

# The AngryCat class might look something like this:

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

smelly_cat = AngryCat.new
# We define a new instance of AngryCat by calling `new` method after the class name.


# Question 5

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

# The `Pizza` class has an instance variable `@name`. The `Fruit` class has a local variable called `name`. We know that `@name` is an instance variable because it starts with one `@`.


# We can ask our class if it has an instance variable by calling `instance_variables` method on an instance of the class:

hot_pizza = Pizza.new('cheese')
orange = Fruit.new('apple')

p hot_pizza.instance_variables
# => [@name]
p orange.instance_variables
# => []


# Question 6

# What is the default return value of to_s when invoked on an object? Where could you go to find out if you want to be sure?

# The default return value of `to_s` when invoked on an object is a string representing the object. It prints the object's class then an encoding of that object's id, such as:
# <Person id @instance_variable='value'>

# https://ruby-doc.org/core-2.7.4/Object.html#method-i-to_s


# Question 7

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

# `self` refers to the object instance of `Cat` that invoked `make_one_year_older` instance method.


# Question 8

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

# Defining a method in the class that starts with `self`, such as `self.cats_count` means the method is a class method. Therefore, `self` refers to the class itself, `Cat`.


# Question 9

# If we have the class below, what would you need to call to create a new instance of this class.

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

# You need to call `Bag.new` and pass in an argument for `color` and `material`, such as:
bag = Bag.new('black', 'leather')
