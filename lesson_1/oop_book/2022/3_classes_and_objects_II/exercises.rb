# 1. Add a class method to your MyCar class that calculates the gas mileage of any car.

class MyCar
  attr_accessor :color, :speed
  attr_reader :year, :model, :mileage

  def self.gas_mileage(range, tank)
    "#{range / tank} miles per gallon"
  end

  def initialize(year, color, model, range, tank)
    @year = year
    self.color = color
    @model = model
    self.speed = 0
    @mileage = MyCar.gas_mileage(range, tank)
  end

  def speed_up(increase)
    self.speed += increase
    puts "Speed increased to #{self.speed}"
  end

  def brake(decrease)
    self.speed -= decrease
    puts "Braked to #{self.speed}"
  end

  def shut_off
    self.speed = 0
    puts "Shut off car"
  end

  def current_speed
    puts "You are going #{self.speed}"
  end

  def spray_paint(color)
    self.color = color
    puts "Color is now #{self.color}"
  end

  def to_s
    "My car is a #{year}, #{color} #{model}"
  end
end

mazda = MyCar.new(2019, 'silver', 'CX-5', 500, 50)
mazda.speed_up(50)
mazda.brake(25)
mazda.current_speed
mazda.shut_off

puts mazda.color
mazda.color = 'black'
puts mazda.color
puts mazda.year

mazda.spray_paint('green')
puts mazda.color

puts MyCar.gas_mileage(500, 50)
puts mazda.mileage


# 2. Override the to_s method to create a user friendly print out of your object.

puts mazda



# 3. When running the following code...

class Person
  # attr_reader :name
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

# We get the following error...

# test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)

# Why do we get this error and how do we fix it?

# We have a getter method for `name` but not a setter method. Therefore, we cannot reassign the `bob` object `name` instance variable to "Bob" after it has be initialized to '"Steve"'

# We can change `attr_reader` to `attr_accessor`
