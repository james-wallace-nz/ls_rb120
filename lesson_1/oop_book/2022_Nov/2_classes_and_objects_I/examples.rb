# class GoodDog
#   # constructor
#   def initialize(name)
#     @name = name
#   end

#   def speak
#     "#{@name} says Arf!"
#   end

#   def name
#     @name
#   end

#   def name=(n)
#     @name = n
#   end
# end

# sparky = GoodDog.new('Sparky')
# puts sparky.speak
# puts sparky.name
# sparky.name = 'Spartacus'
# puts sparky.name

class GoodDog
  attr_accessor :name, :height, :weight

  # constructor
  def initialize(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def speak
    "#{name} says Arf!"
  end

  # def change_info(n, h, w)
  #   @name = n
  #   @height = h
  #   @weight = w
  # end

  # def change_info(n, h, w)
  #   name = n
  #   height = h
  #   weight = w
  # end
  # doesn't change becuase Ruby thinks we are initialising local variables.

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end
  # let Ruby know we're calling a method.

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
  # Can use self.name for getter but not required.
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
puts sparky.info

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info
