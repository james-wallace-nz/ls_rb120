# Refactoring Vehicles

# Consider the following classes:

class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end

end

# Refactor these classes so they all use a common superclass, and inherit behavior as needed.


# Further Exploration

# Would it make sense to define a wheels method in Vehicle even though all of the remaining classes would be overriding it? Why or why not? If you think it does make sense, what method body would you write?

# It makes sense to define a `wheels` method in the `Vehicle` class for polymorphism. Any new subclass of `Vehicle` should have wheels, so should have a default `wheels` method that it can then override. An instance of the `Vehicle` class itself should also have wheels. Polymorphism means that we have a common interface for the `Vehicle` class and any subclasses and can call the `wheels` method on instances of these classes. Each instance of a class may respond differently to the same method call. 



# not all vehicles have wheels. Could have default value set to 0

# I don't think this is a good use of a module. The module has to know too much about the rest of the program to function. You create excessive dependencies this way.

# The module lists all classes with wheels, thus if you add a new subclass of vehicle, you also have to adjust the module. If you need to rewrite code in multiple places when changing a single functionality, that indicates dependencies.
