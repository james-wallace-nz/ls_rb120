class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(name, height, weight)
    self.name = name
    self.height = height
    self.weight = weight
  end

  def change_info(name, height, weight)
    self.name = name
    self.height = height
    self.weight = weight
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def what_is_self
    self
  end

  puts self
  # => GoodDog

end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self
# => #<GoodDog:0x00000001178ad140 @name="Sparky", @height="12 inches", @weight="10 lbs">

# From within the class, when an instance method uses `self` it references the calling object, e.g. the `sparky` object.

# Within the `change_info` instance method, calling `self.name=` is the same as calling `sparky.name=` from outside the class

class MyAwesomeClass
  def self.this_is_a_class_method
  end
end

# Using `self` inside a class but outside an instance method refers to the class itself
# A method definition prefixed with `self` is the same as defining the method on the class `def self.a_method` is equivalent to `def GoodDog.a_method`

# `self` is a way of being explicit about what our program is referencing and what our intentions are as far as behaviour

# `self` changes depending on the scope it is used in.
