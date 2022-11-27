# Encapsulation lets us hide the internal representation of an object from the outside and only expose the methods and properties that users of the object need. We can use method access control to expose these properties and methods through the public (or external) interface of a class: its public methods.

class Dog
  attr_reader :nickname

  def initialize(n)
    @nickname = n
  end

  def change_nickname(n)
    self.nickname = n
  end

  def greeting
    "#{nickname.capitalize} says Woof Woof!"
  end

  private

  attr_writer :nickname
end

dog = Dog.new('rex')
dog.change_nickname('barny')
puts dog.greeting

# we don't need to know how the method is implemented. The main point is that we expect a greeting message from the dog and that's what we get.

# dog.nickname = 'barny'
# => NoMethodError

# even though the `setter` method for `nickname` is private we are still calling it with `self` prepended on line `9`, `self.nickname = n`.
# This is an exception in Ruby. You need to use `self` when calling private setter methods; if you didn't use `self` Ruby would think you are creating a local variable.

# As of Ruby 2.7, it is now legal to call private methods with a literal `self` as the caller. Note that this does not mean that we can call a private method with any other object, not even one of the same type. We can only call a private method with the current object.

# A class should have as few public methods as possible. It lets us simplify using that class and protect data from undesired changes from the outer world
