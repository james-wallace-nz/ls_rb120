class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    'Hello!'
  end
end

class GoodDog < Animal
  attr_accessor :name

  def initialize(color)
    # self.name = n
    super
    @color = color
  end

  def speak
    # "#{self.name} says arf!"
    super + " from GoodDog class"
  end

end

class Cat < Animal
end

class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

sparky = GoodDog.new("Sparky")
paws = Cat.new('Paws')

puts sparky.speak
puts paws.speak

# bruno = GoodDog.new('Brown')
# p bruno
# => @name = 'Brown', @color = 'Brown'

bruce = BadDog.new(2, 'Bruce')
p bruce
# => @name = 'Bruce', @age = 2

class Animal
  def initialize
  end
end

class Bear < Animal
  def initialize(color)
    super()
    @color = color
  end
end

bear = Bear.new('black')
p bear
