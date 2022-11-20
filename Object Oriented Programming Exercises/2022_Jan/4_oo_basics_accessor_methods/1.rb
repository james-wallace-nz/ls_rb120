# Reading and Writing

# Add the appropriate accessor methods to the following code.

class Person
  attr_accessor :name
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name

# Expected output:
# Jessica


class Person
  attr_writer :name
  attr_reader :name
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name


# Discussion

# To access an object's instance variables from outside the object, we need to invoke an accessor method. In the initial example, after the instantiation of person1, we invoke a method named name=. Due to Ruby's syntactical sugar, the method invocation looks like this:

person1.name = 'Jessica'

# Without Ruby's syntactical sugar, it looks like this:

person1.name=('Jessica')

# We can manually implement #name= inside the Person class, like so:

class Person
  def name=(value)
    @name = value
  end
end

# However, using accessor methods is so common in Ruby that there's a built in way to quickly create them.

class Person
  attr_writer :name
end

#attr_writer is a simpler way of implementing #name=. This not only applies to setter methods, like #name=, but to getter methods as well by using #attr_reader.

# You can also use #attr_accessor instead of specifying both #attr_reader and #attr_writer. This is examined in more detail in the next exercise.
