# 1. Create a superclass called Vehicle for your MyCar class to inherit from and move the behavior that isn't specific to the MyCar class to the superclass. Create a constant in your MyCar class that stores information about the vehicle that makes it different from other types of Vehicles.

# Then create a new class called MyTruck that inherits from your superclass that also has a constant defined that separates it from the MyCar class in some way.

module Parkable
  def park
    puts "Parked in carpark"
  end
end

class Vehicle
  attr_accessor :color, :speed
  attr_reader :year, :model

  @@vehicles_created = 0

  def self.gas_mileage(range, tank)
    "#{range / tank} miles per gallon"
  end

  def self.vehicle_count
    puts "#{@@vehicles_created} vehicles created."
  end

  def initialize(year, color, model)
    @year = year
    self.color = color
    @model = model
    self.speed = 0
    @@vehicles_created += 1
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


  def age
    "#{self.model} is #{calculate_age} years old"
  end

  private

  def calculate_age
    Time.now.year - self.year
  end
end


class MyCar < Vehicle
  include Parkable

  attr_reader :mileage

  WHEELS = 4

  def initialize(year, color, model, range, tank)
    super(year, color, model)
    @mileage = MyCar.gas_mileage(range, tank)
  end

  def to_s
    "My car is a #{self.year}, #{self.color} #{self.model}"
  end
end

class MyTruck < Vehicle
  WHEELS = 16

  def initialize(year, color, model)
    super(year, color, model)
  end

  def to_s
    "My truck is a #{self.year}, #{self.color} #{self.model}"
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
mazda.park

mac = MyTruck.new(2020, 'black', 'mack')

Vehicle.vehicle_count


# 2. Add a class variable to your superclass that can keep track of the number of objects created that inherit from the superclass. Create a method to print out the value of this class variable as well.


# 3. Create a module that you can mix in to ONE of your subclasses that describes a behavior unique to that subclass.


# 4. Print to the screen your method lookup for the classes that you have created.

puts MyCar.ancestors
puts
puts MyTruck.ancestors
puts
puts Vehicle.ancestors


# 5. Move all of the methods from the MyCar class that also pertain to the MyTruck class into the Vehicle class. Make sure that all of your previous method calls are working when you are finished.


puts mazda
puts mac


puts mazda.age
puts mac.age

# 6. Write a method called age that calls a private method to calculate the age of the vehicle. Make sure the private method is not available from outside of the class. You'll need to use Ruby's built-in Time class to help.



# 7. Create a class 'Student' with attributes name and grade. Do NOT make the grade getter public, so joe.grade will raise an error. Create a better_grade_than? method, that you can call like so...

# puts "Well done!" if joe.better_grade_than?(bob)

class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end


  def better_than?(other_student)
    grade > other_student.grade
  end

  # you can call protected methods inside the class on other objects of the same class

  protected

  def grade
    @grade
  end

end

joe = Student.new('Joe', 5)
bob = Student.new('Bob', 3)

puts "Well done!" if joe.better_than?(bob)


# 8. Given the following code...


# bob = Person.new
# bob.hi

# And the corresponding error message...


# NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
# from (irb):8
# from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

# What is the problem and how would you go about fixing it?


# There is a `hi` instance method on the Person class but it is private. We need to call another instance method that is public and that method can call the `hi` method from inside the class. Or move the `hi` method above the `private` method call in the class 
