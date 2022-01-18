# Private Secret

# Using the following code, add a method named share_secret that prints the value of @secret when invoked.

class Person
  attr_writer :secret

  def share_secret
    puts secret
  end

  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.share_secret

# Expected output:
# Shh.. this is a secret!

# person1.secret


# Sometimes, certain instance methods don't need to be accessed outside the class. Therefore, it's better to make them private methods, which means they can only be invoked from within the class. We can define methods as private by calling private before the method definition.

# We can invoke a private method from within the class just like we would with any other method. The important thing to realize here is that private methods can't be invoked from outside the class, like this:

class Person
  attr_writer :secret

  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.secret # => private method `secret' called for #<Person:0x007fef1986ac08 @secret="Shh.. this is a secret!"> (NoMethodError)

# We get a NoMethodError because secret is a private getter method.
