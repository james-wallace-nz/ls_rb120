# Consider the following class definition:

class Flight
  # attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# There is nothing technically incorrect about this class, but the definition may lead to problems in the future. How can this class be fixed to be resistant to future problems

# using attr_accessor means we can change the @database_handle instance variable in the future without calling Database.init We can change attr_accessor to attr_reader to only allow reading the instance variable and not setting it.

# using attr_accessor means we are providing easy access to the @database_handle instance variable. This is an implementation detail and we should not be providign direct access to it. Don't provide unneeded and unwanted attr_accessor

# By making access to @database_handle easy, someone may use it. Once it is being used, future modifications to the class may break the code.
