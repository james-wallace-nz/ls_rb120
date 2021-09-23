class MyCar
  attr_accessor :color, :speed
  attr_reader :year, :model

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
end

mazda = MyCar.new(2019, 'silver', 'Mazda CX-5')
puts mazda.speed
mazda.speed_up(100)
puts mazda.speed
mazda.brake(25)
puts mazda.speed
mazda.shut_off
puts mazda.speed

puts '---'

puts mazda.year
puts mazda.color
puts mazda.model
mazda.spray_paint('Pink')
mazda.color