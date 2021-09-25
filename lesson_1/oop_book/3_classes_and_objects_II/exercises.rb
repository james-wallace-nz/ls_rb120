# 1. Add a class method to your MyCar class that calculates the gas mileage of any car.
# 2. Override the to_s method to create a user friendly print out of your object.

class MyCar
  attr_accessor :color, :speed
  attr_reader :year, :model

  def self.mileage(distance, tank)
    # mileage is distance per tank
    puts "#{distance / tank} miles per gallon of gas"
  end

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up(speed_increase)
    self.speed += speed_increase
    puts "You push the gas and accelerate to #{self.speed} mph"
  end

  def brake(speed_decrease)
    self.speed -= speed_decrease
    puts "You are now going #{self.speed} mph"
  end

  def shut_off
    self.speed = 0
    puts "You turn off the car"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{self.color} paint job looks great!"
  end

  def to_s
    "My car is a #{self.year}, #{self.color} #{self.model}"
  end
end

MyCar.mileage(351, 13)
mazda = MyCar.new(2019, 'silver', 'Mazda CX-5')
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
puts bob.name


# We get the following error...

# test.rb:9:in `<main>': undefined method `name=' for
  #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)

# Why do we get this error and how do we fix it?

# with attr_reader there is no setter method `name=`
# Change attr_reader to attr_accessor
