module Towable
  def tow
    puts "I can tow a trailer!"
  end
end

class Truck
  include Towable
end

class Car
end

truck1 = Truck.new
truck1.tow

# Modules are useful for organizing similar methods that may be relevant to multiple classes.
# We use the include method to give Truck access to the #tow method in Towable.
