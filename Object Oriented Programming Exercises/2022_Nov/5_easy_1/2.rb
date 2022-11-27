# Take a look at the following code:

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    # @name.upcase!
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
# 'Fluffy'
# => nil
puts fluffy
# My name is FLUFFY
# => nil
puts fluffy.name
# FLUFFY
# => nil
puts name
# FLUFFY
# => nil

# What output does this code print? Fix this class so that there are no surprises waiting in store for the unsuspecting developer.

# When `puts fluffy` is invoked, `puts` calls `to_s` on the object. The `to_s` method for the `Pet` class first invokes `upcase!` on the `@name` instance variable. This mutates the `@name` instance variable and changes all characters to uppercase.

# When the `fluffy` object is instantiated, the `initialize` instance method invokes `to_s` on the `name` parameter, which returns the same string and assigns it to the instance variable `@name`.

# The string `Fluffy` assigned to `@name` is still the same string `Fluffy` assigned to the local variable `name` on line `16`. When `upcase!` is invoked on line `11`, this mutates the string referenced by the instance variable `@name` , which the local variable `name` also references. Therefore, line `24` and `27` both output the upcase FLUFFY.

puts '---'

# Futher Exploration

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
# 42
# => nil
puts fluffy
# My name is 42
# => nil
puts fluffy.name
# 42
# => nil
puts name
# 43
# => nil

# When the `fluffy` object is instantiated, the `initialize` instance method invokes `to_s` on the `name` parameter, which returns  string representation and assigns it to the instance variable `@name`. This string representaton `42` is now a different object in memory to the integer `42` assigned to `name` local variable on line `43`.
