# 1.

class MyCar
  attr_accessor :color
  attr_reader :year
  attr_writer :current_speed

  def self.mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def initialize(year, model, color)
    @year = year
    @model = model
    self.color = color
    self.current_speed = 0
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
end

lumina = MyCar.new(1997, 'chevy lumina', 'white')
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.shut_down
lumina.current_speed

MyCar.mileage(13, 351)
# => "27 miles per gallon of gas"


# 2.

class MyCar
  attr_accessor :color
  attr_reader :year
  attr_writer :current_speed

  def self.mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def initialize(year, model, color)
    @year = year
    @model = model
    self.color = color
    self.current_speed = 0
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

  def to_s
    "My car is a #{color}, #{@year}, #{@model}"
  end
end

lumina = MyCar.new(1997, 'chevy lumina', 'white')
puts lumina

# 3.

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
puts bob.name
bob.name = "Bob"
puts bob.name

# We get this error because when we try to reassing the `name` instance variable with the`name=` instance method, this settor method doesn't exist when attr_reader is used - only a getter method `name` is available. We can create the setter method by changing it to `attr_accessor
