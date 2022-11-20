# Avoid Mutation

# The following code is flawed. It currently allows @name to be modified from outside the method via a destructive method call. Fix the code so that it returns a copy of @name instead of a reference to it.

class Person
  def initialize(name)
    @name = name
  end

  def name
    @name.clone
  end
end

person1 = Person.new('James')
person1.name.reverse!
puts person1.name

# Expected output:
# James


# Discussion

# In the initial example, @name was modified through the invocation of a destructive method. This is because getter methods typically return a reference to the instance variable. If you use this reference to mutate the return value, you also mutate the instance variable.

# To prevent this, we can invoke the #clone method on @name, which returns a copy of @name instead of a reference to it. This means that any modifications done to the return value won't affect the value of @name. Note that we should also remove the attr_reader line since we are providing a customized getter method.
