module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end

class GoodDog < Animal
  include Swimmable
  include Climbable
end

puts "---Animal method lookup---"
puts Animal.ancestors
# Animal        class
# Walkable      module
# Object        class
# Kernal        module
# BasicObject   class

fido = Animal.new
puts fido.speak
puts fido.walk

puts "---GoodDog method lookup---"
puts GoodDog.ancestors
# GoodDog       class
# Climbable.    module (reverse order of including)
# Swimmable     module
# Animal        class
# Walkable      module
# Object        class
# Kernal        module
# BasicObject   class
