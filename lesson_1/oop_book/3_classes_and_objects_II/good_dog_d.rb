class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(name, age)
    self.name = name
    self.age = age * DOG_YEARS
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end
end

[1, 2,  3]

sparky = GoodDog.new("Sparky", 4)
puts  sparky

p sparky
