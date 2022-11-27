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

# If makes sense to include a wheels mthod in Vehicle and allow sub-classes to override it. If we create a new sub-class of Vehicle without adding its own wheels method, then we would expect to be able to invoke wheels on objects of that class. This would throw an error if Vehicle didn't have a wheels method that the new class can inherit.

# def wheels
#   0
# end
