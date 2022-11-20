# 1.

# We create an object by defining a class and by calling the `new` class method to instantiate a new object of that class.

# class MyClass
# end

# my_obj = MyClass.new


# 2.

# A module groups reusable behaviours in one place that we can then utilise in other classes.

# The purpose is to abstract common behaviours into one place that can be utilised by many classes, rather than duplicating those behaviours in each class directly.

# We define a module:

module Behaviours

end

# and then use the include method invocation to incldue that module in our class(es):

class MyClass
  include behaviours

end
