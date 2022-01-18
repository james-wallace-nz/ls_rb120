# Calculated Age

# Using the following code, multiply @age by 2 upon assignment, then multiply @age by 2 again when @age is returned by the getter method.

class Person
  def age=(age)
    @age = age * 2
  end

  def age
    @age * 2
  end
end

person1 = Person.new
person1.age = 20
puts person1.age

# Expected output:
# 80


# Discussion

# Performing calculations in accessor methods can be convenient if that's the only place you need the calculation to be performed. In the solution, we manually implement both the setter and getter method. In both methods, we multiply the specified value by 2. Pretty straightforward.

# Calculations like these aren't always solely done in accessor methods, however. We can easily implement these calculations both inside the accessor methods and outside by creating a new method, like this:

class Person
  def age=(age)
    @age = double(age)
  end

  def age
    double(@age)
  end

  private

  def double(value)
    value * 2
  end
end

# By structuring our class this way, we can double a given value anywhere we want. Notice, also, that we placed double below private. Due to the calculations all being inside the class, we can restrict access to double from outside the class.
