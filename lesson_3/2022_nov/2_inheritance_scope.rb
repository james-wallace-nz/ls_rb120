# Instance Variables

class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def dog_name
    "bark! bark! #{@name} bark! bark!"
  end
end

teddy = Dog.new('Teddy')
puts teddy.dog_name
# => "bark! bark! Teddy bark! bark!"

# When we instantiated `teddy` we called Dog.new. Without an initialize instance method the super class `Animal#initialize` is called from the method lookup path. That's where @name is initialized and assigned to 'Teddy' passed in.

class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def initialize(name)
  end

  def dog_name
    "bark! bark! #{@name} bark! bark!"
  end
end

teddy = Dog.new('Teddy')
puts teddy.dog_name
# => "bark! bark!  bark! bark!"

# @name returns nil because Dog#initialize doesn't initialize @name. `Animal#initialize` is not called because `Dog#initialize` overrides it.


# Mixing in Modules

module Swim
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swim

  def swim
    'swimming' if @can_swim
  end
end

teddy = Dog.new
teddy.swim
# => nil

# Since we didn't call Swim#enable_swimming instance method, the @can_swim instance variable was never initialized

teddy.enable_swimming
teddy.swim
# => 'swimming'

# We must frist call the method that initializes the instance variable
# This suggests that unlike instance methods, instance variables and their values are not inherited.


# Class Variables

class Animal
  @@total_animals = 0

  def initialize
    @@total_animals += 1
  end
end

class Dog < Animal
  def total_animals
    @@total_animals
  end
end

spike = Dog.new
spike.total_animals
# => 1

# Class variables are accessible to sub-classes
# No method to invoke to initialize the class variable. Therefore, the class variable is loaded when the class is evaluated by Ruby

# There is only one copy of the class variable across all sub-classes

# We initialize the class variable then expose a class method to return the value of the class variable

class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

Vehicle.wheels
# => 4

class Motorcycle < Vehicle
  @@wheels = 2
end

Motorcycle.wheels
# => 2

Vehicle.wheels
# => 2

class Car < Vehicle
  # @@wheels = 4
end

Car.wheels
# => 2

# If row 122 included
# => 4

# Avoid using class variables when working with inheritance
# Solution is usually to use class instance variables


# Constants

# Ruby first attempts to resolve a constant by searching in the lexical scope of that reference. Then it will traverse the hierarchy of the structure that references the constant.

module FourWheeler
  WHEELS = 4
end

class Vehicle
  def maintenance
    "Changinge #{WHEELS} tires."
  end
end

class Car < Vehicle
  include FourWheeler

  def wheels
    WHEELS
  end
end

car = Car.new
car.wheels
# # => 4

# Ruby searches ancestors of Car class and finds WHEELS in FourWheeler module

car.maintenance
# => NameError

# Vehicle#maintenance is invoked and WHEELS is not in the lookup hierarchy as FourWheeler module is included in Car not Vehicle

# Vehicle class encloses the reference to WHEELS, not the Car class despite the fact that an instance of Car called the method.wheels

# Lexical scope doesn't incldue the main scope (top level)

class Vehicle
  WHEELS = 4
end

WHEELS = 6

class Car < Vehicle
  def wheels
    WHEELS
  end
end

car = Car.new
car.wheels
# => 4

# If line 167 commented out
# => 6

# Ruby searches the lexical scope up to but not include the main scope
# Then Ruby searches by inheritance where WHEELS constant is found in the Vehicle class
# The top level scope is only searched after Ruby tries the inheritance hierarchy
