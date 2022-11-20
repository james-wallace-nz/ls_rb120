# namespacing means organising similar classes under a module

module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end
end

buddy = Mammal::Dog.new
kitty = Mammal::Cat.new
buddy.speak('Arf!')
kitty.say_name("Kitty")

# modules as a container for methods - module methods

module Mammal
  def self.some_out_of_place_method(num)
    num ** 2
  end
end

# preferred:
puts value1 = Mammal.some_out_of_place_method(4)

puts value2 = Mammal::some_out_of_place_method(4)
