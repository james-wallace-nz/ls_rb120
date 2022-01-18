# 1. Given the below usage of the Person class, code the class definition.

# class Person 
#   attr_accessor :name
#   def initialize(name)
#     self.name = name
#   end
# end

# bob = Person.new('bob')
# puts bob.name                  # => 'bob'
# bob.name = 'Robert'
# puts bob.name                  # => 'Robert'


# 2. Modify the class definition from above to facilitate the following methods. Note that there is no name= setter method now.

# class Person 
#   attr_reader :first_name, :last_name, :name


#   def initialize(first_name = '', last_name = '')
#     @first_name = first_name
#     @last_name = last_name
#     @name = first_name + ' ' + last_name
#   end

#   def last_name=(new_last_name)
#     @last_name = new_last_name
#     @name = @first_name + ' ' + @last_name
#   end

# end

# class Person 
#   attr_accessor :first_name, :last_name


#   def initialize(full_name) # first_name = '', last_name = '')
#     # @first_name = first_name
#     # @last_name = last_name
#     parts = full_name.split
#     @first_name = parts.first
#     @last_name = parts.size > 1 ? parts.last : ''
#   end

#   def name
#     @first_name + ' ' + @last_name
#   end

# end

# bob = Person.new('Robert')
# puts bob.name                  # => 'Robert'
# puts bob.first_name            # => 'Robert'
# puts bob.last_name             # => ''
# bob.last_name = 'Smith'
# puts bob.name                  # => 'Robert Smith'


# 3. Now create a smart name= method that can take just a first name or a full name, and knows how to set the first_name and last_name appropriately.

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name=(name)
    parse_full_name(name)
  end

  def name
    @first_name + ' ' + @last_name
  end

  def to_s
    name
  end

  private

  def parse_full_name(name)
    parts = name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end

# bob = Person.new('Robert')
# puts bob.name                  # => 'Robert'
# puts bob.first_name            # => 'Robert'
# puts bob.last_name             # => ''
# bob.last_name = 'Smith'
# puts bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# puts bob.first_name            # => 'John'
# puts bob.last_name             # => 'Adams'


# 4. Using the class definition from step #3, let's create a few more people -- that is, Person objects.

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

# If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?

puts bob.name == rob.name

# We would not be able to do bob == rob because that compares whether the two Person objects are the same, and right now there's no way to do that. We have to be more precise and compare strings:

bob.name == rob.name

# The above code compares a string with a string. But aren't strings also just objects of String class? If we can't compare two Person objects with each other with ==, why can we compare two different String objects with ==?

str1 = 'hello world'
str2 = 'hello world'

str1 == str2          # => true

# What about arrays, hashes, integers? It seems like Ruby treats some core library objects differently. For now, memorize this behavior. We'll explain the underpinning reason in a future lesson.


# 5. Continuing with our Person class definition, what does the below print out?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

# This prints the string with the object concatenated as puts calls `to_s` on the object automatically

# The person's name is: #<Person:...>


# This is because when we use string interpolation (as opposed to string concatenation), Ruby automatically calls the to_s instance method on the expression between the #{}. Every object in Ruby comes with a to_s inherited from the Object class. By default, it prints out some gibberish, which represents its place in memory.

# If we do not have a to_s method that we can use, we must construct the string in some other way. For instance, we can use:

puts "The person's name is: " + bob.name        # => The person's name is: Robert Smith

# or

puts "The person's name is: #{bob.name}"        # => The person's name is: Robert Smith


# Let's add a to_s method to the class:

# class Person
#   # ... rest of class omitted for brevity

#   def to_s
#     name
#   end
# end

# Now, what does the below output?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

# The person's name is: Robert Smith