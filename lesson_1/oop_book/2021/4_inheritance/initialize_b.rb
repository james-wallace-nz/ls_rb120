class Animal
  def initialize

  end
end

class Bear < Animal
  attr_accessor :color

  def initialize(color)
    super()
    self.color = color
  end
end

bear = Bear.new('black')
p bear