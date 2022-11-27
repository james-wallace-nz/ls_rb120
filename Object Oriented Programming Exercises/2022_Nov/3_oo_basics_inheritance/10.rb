# Create a module named Transportation that contains three classes: Vehicle, Truck, and Car. Truck and Car should both inherit from Vehicle.

module Transportation
  class Vehicle
  end

  class Truck < Vehicle
  end

  class Car < Vehicle
  end
end

# Namespacing is where similar classes are grouped within a module. This makes it easier to recognize the purpose of the contained classes. Grouping classes in a module can also help avoid collision with classes of the same name.

mack = Transportation::Truck.new
