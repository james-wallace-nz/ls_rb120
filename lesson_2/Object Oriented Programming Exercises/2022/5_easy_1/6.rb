# Fix the Program - Flight Data

# Consider the following class definition:

class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# There is nothing technically incorrect about this class, but the definition may lead to problems in the future. How can this class be fixed to be resistant to future problems?


# On `line 9` the Database is initialized and assigned to the `@database_handle` instance variable. On `line 6`, `attr_accessor` creates a setter method for `@database_handle`, which means that instance variable can be reassigned. It may be better to change this to `attr_reader` so the `@database_handle` can't be reassigned after initial inialization. 


# Discussion

# The problem with this definition is that we are providing easy access to the @database_handle instance variable, which is almost certainly just an implementation detail. As an implementation detail, users of this class should have no need for it, so we should not be providing direct access to it.

# The fix is easy: don't provide the unneeded and unwanted attr_accessor.

# What can go wrong if we don't change things? First off, by making access to @database_handle easy, someone may use it in real code. And once that database handle is being used in real code, future modifications to the class may break that code. You may even be prevented from modifying your class at all if the dependent code is of greater concern.
