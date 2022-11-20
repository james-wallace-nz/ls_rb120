# 1, 2, 3, 4, 5, 6.

module Towable
  def can_two(weight)
    weight < 2000
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :year, :model
  attr_writer :current_speed

  @@vehicles_created = 0

  def self.mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def initialize(year, model, color)
    @year = year
    @model = model
    self.color = color
    self.current_speed = 0
    @@vehicles_created += 1
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def self.vehicles_created
    "#{@@vehicles_created} vehicle(s) created."
  end

  def age
    "Your #{self.model} is #{calculate_age} years old."
  end

  private

  def calculate_age
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  WHEELS = 4

  def initialize(year, model, color)
    super
  end

  def to_s
    "My car is a #{color}, #{@year}, #{@model}"
  end
end

class MyTruck < Vehicle
  include Towable
  WHEELS = 8

  def to_s
    "My truck is a #{color}, #{@year}, #{@model}"
  end
end

lumina = MyCar.new(1997, 'chevy lumina', 'white')
puts lumina
puts lumina.age

mack = MyTruck.new(2022, 'Mac', 'Black')
puts mack
puts mack.age

puts Vehicle.vehicles_created

puts Vehicle.ancestors
puts MyCar.ancestors
puts MyTruck.ancestors


# 7.

class Student
  attr_accessor :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  attr_reader :grade
end

joe = Student.new('Joe', 10)
bob = Student.new('Bob', 9)
puts "Well done!" if joe.better_grade_than?(bob)


# 8.

# the `hi` instance method is private so cannot be invoked outside of the class. We can call the `hi` method from another method in the class or move it above the private method call in the class.
