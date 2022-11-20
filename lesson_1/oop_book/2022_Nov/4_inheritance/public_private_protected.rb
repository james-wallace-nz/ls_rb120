# Method Access Control implemented via access modifiers
# - allow or restric access to a particular thing (methods defined in a class)

# `public`, `private`, `protected` access modifiers

# Public mehotd is available to anyone who knows the class name or object name. Comprise the class' interface (how other classes and objects interact with this class and its objects).

# `private` method call and anything below is private (unless another method like `protected` is called).

# Private methods are only accessible from other methods in the class

class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
  end

  def public_disclosure
    "#{name} in human years is #{human_years}"
  end

  private

  def human_years
    age * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)
# puts sparky.human_years
# => NoMethodError - private method
puts sparky.public_disclosure

# self.human_years is equivalent to sparky.human_years, which won't work because it is private

# Private methods are not accessible outside of the class definition at all. Only accessible inside the class when called without self

# `protected` methods cannot be invoked outside the class. Protected methods allow access between class instances, while private methods do not

class Person
  def initialize(age)
    @age = age
  end

  def older?(other_person)
    age > other_person.age
  end

  protected

  attr_reader :age
end

malory = Person.new(64)
sterling = Person.new(42)

puts malory.older?(sterling)
puts sterling.older?(malory)

# malory.age
# NoMethodError: protected method 'age'
