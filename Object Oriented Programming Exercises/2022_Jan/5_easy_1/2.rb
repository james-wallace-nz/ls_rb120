# What's the Output?

# Take a look at the following code:

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    # @name.upcase!
    "My name is #{@name}." # #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# What output does this code print? Fix this class so that there are no surprises waiting in store for the unsuspecting developer.


# `name = "Fluffy"` assigns the `String` value "Fluffy" to the local variable `name`. 

# `Pet.new(name)` calls the `initialize` method with `name` as an argument. This assigns the result of `name.to_s` to the instance variable `@name`. The `to_s` method called on `name` returns the same `String` object that `name` references. Therefore, the `@name` instance variable references the same String object as the local variable `name`.

# The new `Pet` object is assigned to the local variable `fluffy`. 

# The first `puts fluffy.name` call will output "My name is Fluffy".

# When `puts` is invoked with `fluffy` as the argument, the `to_s` method is automatically called on the `fluffy` instance of the `Pet` class. 

# The `Pet` class has a `to_s` method that overrides the default `Object` class `to_s` method. When the `Pet#to_s` method is called, the value that `@name` instance variable references is converted to uppercase by the `upcase!` method called on it. This mutates the caller meaning the value `"Fluffy"` has been mutated to `"FLUFFY"`. Now both `@name` and `name` reference the same String with value `"FLUFFY"`. So, "My name is FLUFFY" is then output.

# The second time that `fluffy.name` is called, `@name` is now uppercase. So `"FLUFFY"` is output.

# When puts name is invoked, `"FLUFFY"` will be output because the `name` local variable references the mutated String value.last

# We can fix this by calling the `upcase` method on `@name` in the string interpolation on `line 14`, or changing @name to equal `name.clone.to_s`.


# Discussion

# The original version of #to_s uses String#upcase! which mutates its argument in place. This causes @name to be modified, which in turn causes name to be modified: this is because @name and name reference the same object in memory.


# Further Exploration

# What would happen in this case?

# Assuming that the original code is in place...

name = 42
fluffy = Pet.new(name)
# 42.to_s is assigned to the instance variable `@name`. The `Stirng` "42" is a different object to the `Integer` `42`. 

name += 1
# `name` local variable is reassigned to the value of `name` + `1`, which is `43`.

puts fluffy.name        # 42  `String` object "42" is output

puts fluffy             # 42 is uppercased and output is "My name is 42"

puts fluffy.name        # 42 is output having been uppercased

puts name               # the reassigned name variable is output, `43`.

# This code "works" because of that mysterious to_s call in Pet#initialize. However, that doesn't explain why this code produces the result it does. Can you?
