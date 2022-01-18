class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self-weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def what_is_self
    self
  end
end

sparky = GoodDog.new("Sparky", "12 inches", "10 lbs")
p sparky.what_is_self

class MyAwesomeClass
  def self.this_is_a_class_methods

  end

end


class GoodDogB
  # ... rest of code omitted for brevity
  puts self
end

GoodDogB
