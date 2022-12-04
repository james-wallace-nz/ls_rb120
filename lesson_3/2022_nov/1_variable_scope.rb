# Instance Variable Scope

class Person
  def initialize(n)
    @name = n
  end
end

bob = Person.new('Bob')
joe = Person.new('Joe')

puts bob.inspect
puts joe.inspect
# => <Person @name='Bob'>
# => <Person @name='Joe'>

# @ scoped at the object level
# track individual object state
# do not cross over between objects

# an object's instance variables are accessible in the object's instance methods even if initialized outside of that method and not passed in as an argument.

class Person
  def initialize(n)
    @name = n
  end

  def get_name
    @name             # @name instance variable accessible here
  end
end

bob = Person.new('Bob')
puts bob.get_name
# => 'Bob'

# accessing an instance variable not yet initialized returns nil

class Person
  def get_name
    @name           # @name not initialized anywhere
  end
end

bob = Person.new
bob.get_name
# => nil


# instance variable at the class level is a class instance variable

class Person
  @name = 'Bob'       # class level initialization

  def get_name
    @name
  end
end

bob = Person.new
bob.get_name
# => nil


# Class Variable Scope

# @@ scoped at the class level
# - all objects share 1 copy of the class variable
  # => object instance methods can access class variables
# - class methods can access class variable provided it has been initialized prior to calling the method

class Person
  @@total_people = 0      # initialized at class level

  def self.total_people
    @@total_people        # accessible from class method
  end

  def initialize
    @@total_people += 1   # reassigned from instance method
  end

  def total_people
    @@total_people        # accessible from instance method
  end
end

Person.total_people
# => 0

Person.new
Person.new
Person.total_people
# => 2

bob = Person.new
bob.total_people
# => 3

joe = Person.new
joe.total_people
# => 4

Person.total_people
# => 4

# Effectively accessing and modifying one copy of @@total_people class variable when using instance methods
# Only class variables can share state between objects


# Constant Variable Scope

# Constants have lexical scope
# Means that where the constant is defined determines where it is available
# When Ruby tries to resolve a constant it searches lexically - the surrounding structure (lexical scope) of the constant reference

class Person
  GREETINGS = ['Hello', 'Hi', 'Hey']

  def self.greetings
    GREETINGS.join(', ')
  end

  def greet
    GREETINGS.sample
  end
end

puts Person.greetings
# => 'Hello, Hi, Hey'

puts Person.new.greet
# => 'Hello', 'Hi' or 'Hey'

# Ruby searches the surrounding code - since GREETINGS initialized within the Person class it is accessible in Person::greetings and Person#greet

module ElizabethanEra
  GREETINGS = ['How dost thou', 'Bless thee', 'Good morrow']

  class Person
    def self.greetings
      GREETINGS.join(', ')
    end

    def greet
      GREETINGS.sample
    end
  end
end

puts ElizabethanEra::Person.greetings
# => 'How dost thou, Bless thee, Good morrow'
puts ElizabethanEra::Person.new.greet
# => 'How dost thou' or 'Bless thee' or 'Good morrow'

# GREETINGS can still be resolved because it's available lexically

# Referencing a constant from another class throws a NameError as it is not part of the lexical search and not included in the constant lookup path.

class Computer
  GREETINGS = ['Beep', 'Boop']
end

class Person
  def self.greetings
    GREETINGS.join(', ')
  end

  def greet
    GREETINGS.sample
  end
end

puts Person.greetings
# => NameError

puts Person.new.greet
# => NameError

# We can use the namespace resolution operator to reach into the Computer class and tell Ruby to search for GREETINGS constant.

class Computer
  GREETINGS = ['Beep', 'Boop']
end

class Person
  def self.greetings
    Computer::GREETINGS.join(', ')
  end

  def greet
    Computer::GREETINGS.sample
  end
end

puts Person.greetings
# => 'Beep, Boop'
puts Person.new.greet
# => 'Beep' or 'Boop'
