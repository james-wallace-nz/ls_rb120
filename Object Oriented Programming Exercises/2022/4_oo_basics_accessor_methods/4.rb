# Choose the Right Method

# Using the following code, add the appropriate accessor methods. Keep in mind that the last_name getter shouldn't be visible outside the class, while the first_name getter should be visible outside the class.

class Person
  attr_accessor :first_name
  attr_writer :last_name

  def first_equals_last?
    first_name == last_name
  end

  private

  attr_reader :last_name

end

person1 = Person.new
person1.first_name = 'Dave'
person1.last_name = 'Smith'
puts person1.first_equals_last?

# Expected output:
# false


# Discussion

# When handling data within a class, sometimes certain data needs to be kept private, meaning that only the object knows what the data is. In this case, we want to control access to @last_name. We only want to allow the Person to retrieve that value.

# To accomplish this, we place #attr_reader after the call to private. This means that only Person has access to this method. Public methods, like first_equals_last?, can be used to access @last_name through the private accessor method. However, last_name can't be invoked outside the class.

class PersonB
  attr_writer :last_name

  private

  attr_reader :last_name
end

person2 = PersonB.new
person2.last_name = 'Smith'
person2.last_name # => NoMethodError

# We get a NoMethodError because last_name is a private method.
