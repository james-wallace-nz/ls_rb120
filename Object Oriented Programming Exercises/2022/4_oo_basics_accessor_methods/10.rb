# Unexpected Change

# Modify the following code to accept a string containing a first and last name. The name should be split into two instance variables in the setter method, then joined in the getter method to form a full name.

class Person
  def name=(name)
    parts = name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

  def name
    @first_name + ' ' + @last_name
  end

  private

  # attr_accessor :first_name, :last_name
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name

# Expected output:
# John Doe


# Discussion

# When writing the accessor method for a class, it can be difficult to plan for change. Sometimes, when you first create the class, no extra functionality is needed. Then, later on, the method needs to do something extra. In this case, we had a single accessor method, but now we need to manually write both the setter and getter method, to incorporate the requested functionality.

# Starting with the setter method, we're still only dealing with one argument. However, we know that the argument is a string that has two names, first and last, that are separated by a single space. The goal is to create two instance variables: @first_name and @last_name. We can accomplish this by using the #split method to separate each name and assign them to the appropriate variable.

# As for the getter method, we can't just return @name because that instance variable doesn't exist. Instead, we have two variables that we need to combine into a full name. We do this simply by adding both variables to a string, separated by a space, and returning that string.
  