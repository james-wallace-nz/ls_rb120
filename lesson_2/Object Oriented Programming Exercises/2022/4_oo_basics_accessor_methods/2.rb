# Choose the Right Method

# Add the appropriate accessor methods to the following code.

class Person
  attr_writer :phone_number #, :name
  # attr_reader :name
  attr_accessor :name
end

person1 = Person.new
person1.name = 'Jessica'
person1.phone_number = '0123456789'
puts person1.name

# Expected output:
# Jessica


# Discussion

# In the solution, we invoke #attr_accessor so that we have both a getter and a setter method for the instance variable @name. In the initial example, however, a new method is invoked named phone_number=. We can tell this is a setter method by the = symbol appended to the name.

# We want to be able to modify the value of @phone_number, but not retrieve it. In this class, we're choosing to keep the phone number a secret. The next step then, is choosing which accessor method to use based on the criteria just described. If we used #attr_reader or #attr_accessor, we would be creating a getter method, which isn't what we want. Therefore, we can safely say that #attr_writer is the best option here.
