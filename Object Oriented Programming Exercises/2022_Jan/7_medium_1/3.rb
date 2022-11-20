# Students

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
  # def initialize(name, year)
  #   super
  # end
end

# Discussion

# A few things need to be changed to fulfill the requirements of this exercise. First, notice that a Graduate and an Undergraduate should be subclasses of Student. All three should share two points of data, the name and the year.

# To share that data we can use the keyword super. super calls a method further up the inheritance chain that has the same name as the enclosing method. By enclosing method, we mean the method where we are calling the keyword super. In this case, we want to call the Student#initialize method from within Graduate#initialize and Undergraduate#initialize.

# For Undergraduate, we call super without any arguments; this causes all arguments from the calling method to be passed to the superclass method that has the same name. Thus, we end up passing both name and year to Student#initialize.

# We can also delete the entire Undergraduate#initialize method; since it only calls Student#initialize with the same arguments and does nothing else, we can omit it.
# Dealing with the Graduate class is a bit trickier. We don't want to pass all the arguments from Graduate#initialize to Student#initialize. If we do, we'll get an error since there are too many arguments. To avoid this, we need to specify the arguments we wish to pass to Student#initialize by explicitly passing those arguments to super:

# Copy Code
# super(name, year)
# This passes just the name and year to Student#initialize; the parking parameter will not be included.

# Finally, we should ensure that graduate students have access to parking if they want it. This is accomplished by setting the parking parameter to an instance variable @parking from within Graduate#initialize.

# With all that done, we have satisfied the requirements of this exercise, and have gotten a bit more practice with the keyword super in the process.

# Further Exploration

# There is one other "form" of the keyword super. We can call it as super(). This calls the superclass method of the same name as the calling method, but here no arguments are passed to the superclass method at all.

# Can you think of a way to use super() in another Student related class?
