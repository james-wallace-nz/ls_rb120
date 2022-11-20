# 1.

class MyCar
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def speed_up(increase)
    @speed += increase
  end

  def brake(decrease)
    @speed -= decrease
  end

  def shut_off
    @speed = 0
  end

  def current_speed
    @speed
  end

  def info
    "#{@year}, #{@color}, #{@model}"
  end
end

cx5 = MyCar.new(2019, 'grey', 'CX-5')
puts cx5.info
puts cx5.current_speed

cx5.speed_up(20)
cx5.speed_up(20)
puts cx5.current_speed

cx5.brake(20)
puts cx5.current_speed

cx5.shut_off
puts cx5.current_speed

puts '---'


# 2.

class MyCar
  attr_accessor :color
  attr_reader :year, :model, :speed

  def initialize(y, c, m)
    @year = y
    self.color = c
    @model = m
    @speed = 0
  end

  def speed_up(increase)
    @speed += increase
  end

  def brake(decrease)
    @speed -= decrease
  end

  def shut_off
    @speed = 0
  end
end

cx5 = MyCar.new(2019, 'grey', 'CX-5')
puts cx5.year
puts cx5.color
puts cx5.model
puts cx5.speed

cx5.speed_up(20)
cx5.speed_up(20)
puts cx5.speed

cx5.brake(20)
puts cx5.speed

cx5.shut_off
puts cx5.speed

cx5.color = 'green'
puts cx5.color

puts '---'

# 3.

class MyCar
  attr_accessor :color
  attr_reader :year, :model, :speed

  def initialize(y, c, m)
    @year = y
    self.color = c
    @model = m
    @speed = 0
  end

  def speed_up(increase)
    @speed += increase
  end

  def brake(decrease)
    @speed -= decrease
  end

  def shut_off
    @speed = 0
  end

  def spray_paint(color)
    self.color = color
  end
end

cx5 = MyCar.new(2019, 'grey', 'CX-5')
puts cx5.color

cx5.spray_paint('green')
puts cx5.color
