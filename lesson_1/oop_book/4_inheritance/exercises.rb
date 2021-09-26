# 1. Create a superclass called Vehicle for your MyCar class to inherit from and move the behavior that isn't specific to the MyCar class to the superclass. Create a constant in your MyCar class that stores information about the vehicle that makes it different from other types of Vehicles.

# Then create a new class called MyTruck that inherits from your superclass that also has a constant defined that separates it from the MyCar class in some way.


# 2. Add a class variable to your superclass that can keep track of the number of objects created that inherit from the superclass. Create a method to print out the value of this class variable as well.


# 3. Create a module that you can mix in to ONE of your subclasses that describes a behavior unique to that subclass.

module Storable
  def store
    puts "Backdoor opened, goods stored."
  end
end

module Towable
  def can_tow?(weight)
    weight < 2000 ? true: false
  end
end

class Vehicle
  attr_accessor :color, :speed
  attr_reader :year, :model

  @@number_of_vehicles = 0

  def self.number_of_vehicles
    puts @@number_of_vehicles
  end

  def self.gas_mileage(tank, distance)
    # mileage is distance per tank
    puts "#{distance / tank} miles per gallon of gas"
  end

  def initialize(year, color, model)
    @@number_of_vehicles += 1
    @year = year
    self.color = color
    @model = model
    self.speed = 0
  end

  def current_speed
    puts "Current speed is #{self.speed} mph."
  end

  def speed_up(speed_increase)
    self.speed += speed_increase
    puts "You push the gas and accelerate to #{self.speed} mph"
  end

  def brake(speed_decrease)
    self.speed -= speed_decrease
    puts "You are now going #{self.speed} mph"
  end

  def shut_down
    self.speed = 0
    puts "You turn off the vehicle"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{self.color} paint job looks great!"
  end
end

class MyCar < Vehicle
  WHEELS = 4
  NUMBER_OF_DOORS = 4

  # def initialize(year, color, model)
  #   super()
  #   @year = year
  #   @color = color
  #   @model = model
  #   @speed = 0
  # end

  def to_s
    "My car is a #{self.year}, #{self.color} #{self.model}"
  end
end

class MyTruck < Vehicle
  include Storable, Towable

  WHEELS = 16
  NUMBER_OF_DOORS = 2

  def to_s
    "My truck is a #{self.year}, #{self.color} #{self.model}"
  end
end

Vehicle.number_of_vehicles

mazda = MyCar.new(2019, 'silver', 'Mazda CX-5')
mac_truck = MyTruck.new(2021, 'black', 'Mac Truck')
puts mazda
puts mac_truck

Vehicle.number_of_vehicles

mac_truck.store
puts mac_truck.can_tow?(1500)

# 4. Print to the screen your method lookup for the classes that you have created.

puts "---"
puts Vehicle.ancestors
puts "---"
puts MyCar.ancestors
puts "---"
puts MyTruck.ancestors


# 5. Move all of the methods from the MyCar class that also pertain to the MyTruck class into the Vehicle class. Make sure that all of your previous method calls are working when you are finished.

puts "---"
lumina = MyCar.new(1997, 'chevy lumina', 'white')
lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.shut_down
MyCar.gas_mileage(13, 351)
lumina.spray_paint("red")
puts lumina
puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors


# 6. Write a method called age that calls a private method to calculate the age of the vehicle. Make sure the private method is not available from outside of the class. You'll need to use Ruby's built-in Time class to help.




# 7. Create a class 'Student' with attributes name and grade. Do NOT make the grade getter public, so joe.grade will raise an error. Create a better_grade_than? method, that you can call like so...


class Student
  attr_accessor :name
  attr_writer :grade

  def initialize(name, grade)
    self.name = name
    self.grade = grade
  end

  def better_grade_than?(person)
    self.grade > person.grade
  end

  protected

  attr_reader :grade
end

joe = Student.new('Joe', 4)
bob = Student.new('Bob', 3)
puts joe.name

puts "Well done!" if joe.better_grade_than?(bob)


# 8. Given the following code...

bob = Person.new
bob.hi

# And the corresponding error message...

# NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
# from (irb):8
# from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

# What is the problem and how would you go about fixing it?

# The `hi` instance method of `Person` class exists, but it is a private method. Therefore, it is only accessible from other methods in the class. We could change this to a protected method or public method.
