class GoodDog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    # "#{@name} says arf!"
    "#{name} says arf!"     # Change to use getter `name` method instead of referencing the instance variable directly
  end
end

sparky = GoodDog.new('Sparky')
puts sparky.speak
puts sparky.name
sparky.name = 'Spartacus'
puts sparky.name