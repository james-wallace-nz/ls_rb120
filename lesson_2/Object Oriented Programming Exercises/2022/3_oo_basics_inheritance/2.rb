# Start the Engine (part 1)

# Change the following code so that creating a new Truck automatically invokes #start_engine.

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle

  def initialize(year)
    super(year)
    start_engine
  end

  def start_engine
    puts 'Ready to go!'
  end
end

truck1 = Truck.new(1994)
puts truck1.year

# Expected output:
# Ready to go!
# 1994


# When you invoke #super within a method, Ruby looks in the inheritance hierarchy for a method with the same name. 

# Invoking #super without parentheses passes all arguments to Vehicle#initialize.
