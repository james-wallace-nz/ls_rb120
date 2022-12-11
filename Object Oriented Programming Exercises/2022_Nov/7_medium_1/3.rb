# Below we have 3 classes: Student, Graduate, and Undergraduate. The implementation details for the #initialize methods in Graduate and Undergraduate are missing. Fill in those missing details so that the following requirements are fulfilled:

# Graduate students have the option to use on-campus parking, while Undergraduate students do not.

# Graduate and Undergraduate students both have a name and year associated with them.

# Note, you can do this by adding or altering no more than 5 lines of code.

class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super
  end
end


# super calls a method further up the inheritance chain that has the same name as the enclosing method. By enclosing method, we mean the method where we are calling the keyword super.

# For Undergraduate, we call super without any arguments; this causes all arguments from the calling method to be passed to the superclass method that has the same name. Thus, we end up passing both name and year to Student#initialize.

# We can also delete the entire Undergraduate#initialize method; since it only calls Student#initialize with the same arguments and does nothing else, we can omit it.

# we need to specify the arguments we wish to pass to Student#initialize by explicitly passing those arguments to super

