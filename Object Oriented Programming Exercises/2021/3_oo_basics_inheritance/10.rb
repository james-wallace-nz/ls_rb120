module Transportation
  class Vehicle
  end

  class Truck < Vehicle
  end

  class Car < Vehicle
  end
end

# Modules are useful for namespacing. Namespacing is where similar classes are grouped within a module.
# This makes it easier to recognise the purpose of the contained classes.
# Grouped classes in a module can also help avoid collision with classes of the same name.

# Instantiate a class that's contained in a module by invoking:
truck = Transportation::Truck.new
puts truck
