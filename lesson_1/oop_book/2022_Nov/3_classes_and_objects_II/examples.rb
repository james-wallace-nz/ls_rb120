class GoodDog
  # constant
  DOG_YEARS = 7

  attr_accessor :name, :age

  # class variable
  @@number_of_dogs = 0

  def initialize(n, a)
    @@number_of_dogs += 1
    self.name = n
    self.age = a * DOG_YEARS
  end

  # class method
  def self.total_number_of_dogs
    @@number_of_dogs
  end

  # override default `to_s`
  def to_s
    "This dog's name is #{name} and it is #{age} in dogs years"
  end
end

# puts GoodDog.total_number_of_dogs

# dog1 = GoodDog.new
# dog2 = GoodDog.new

# puts GoodDog.total_number_of_dogs

sparky = GoodDog.new('Sparky', 4)
puts sparky.age

puts GoodDog::DOG_YEARS
# => 7

puts sparky
# => This dog's name is Sparky and is 28 in dog years.

# `puts` automatically calls `to_s` on its argument, which is the sparky object
# equivalent to `puts sparky.to_s`

# by default `to_s` returns the name of the object's class and an encoding of the object id.

# `puts` calls `to_s` for any argument that is not an array. For an array, `puts` writes on separate lines the result of calling `to_s` on each element in the array

# `p` doesn't call `to_s` on its argument, it calls `inspect`.
p sparky
# => #<GoodDog:0x007fe54229b358 @name="Sparky", @age=28>

# equivalent to
puts sparky.inspect

# `to_s` automatically called in string interpolation
puts "#{sparky}"
