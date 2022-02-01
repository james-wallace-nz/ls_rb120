class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  def initialize(year)
    super
    start_engine
  end

  def start_engine
    puts 'Ready to go!'
  end
end

truck1 = Truck.new(1994)
puts truck1.year

# Ruby stops looking for the method as soon as it finds it. Thus, Truck#start_engine overrides Vehicle#start_engine. What if we want to override a method, but still have access to functionality from a superclass? Ruby provides a reserved word for this: super.

# When you invoke #super within a method, Ruby looks in the inheritance hierarchy for a method with the same name. In the solution, we use #super to invoke Vehicle#initialize, then we invoke #start_engine. Invoking #super without parentheses passes all arguments to Vehicle#initialize.
