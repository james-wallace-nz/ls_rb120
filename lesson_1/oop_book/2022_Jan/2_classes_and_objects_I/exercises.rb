# 1. Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.


class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up(increase)
    @speed += increase
    puts "Speed increased to #{@speed}"
  end

  def brake(decrease)
    @speed -= decrease
    puts "Braked to #{@speed}"
  end

  def shut_off
    @speed = 0
    puts "Shut off car"
  end

  def current_speed
    puts "You are going #{@speed}"
  end

  def spray_paint(color)
    self.color = color
    puts "Color is now #{@color}"
  end
end

mazda = MyCar.new(2019, 'silver', 'CX-5')
mazda.speed_up(50)
mazda.brake(25)
mazda.current_speed
mazda.shut_off


# 2. Add an accessor method to your MyCar class to change and view the color of your car. Then add an accessor method that allows you to view, but not modify, the year of your car.

puts mazda.color
mazda.color = 'black'
puts mazda.color
puts mazda.year



# 3. You want to create a nice interface that allows you to accurately describe the action you want your program to perform. Create a method called spray_paint that can be called on an object and will modify the color of the car.


mazda.spray_paint('green')
puts mazda.color
