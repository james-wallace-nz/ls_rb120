# 3 + 'z'

# Exception Class Hierarchy

  # Top of the hierarchy is the Exception class, which has sub-classes which may have their own decendents

  # Exception
  #   NoMemoryError
  #   ScriptError
  #     LoadError
  #     SyntaxError           Invalid syntax
  #  SignalException
  #    Interrupt              When exiting with ctrl + c
  #  StandardError
  #    ArgumentError
  #    IndexError
  #    NameError
  #      NoMethodError
  #    RangeError
  #    RegexpError
  #    RuntimeError
  #    TypeError
  #    ZeroDivisionError
  #   SystemStackError        stack overflow


# When to Handle an Exception?

  # Most often we want to handle descendents of `StandardError`.
  # May be cause by unexpected user input, faulty type conversions, dividing by zero
  # Generally safe to handle and continue running the programme

  # There are some errors that we should allow to crash our programme - LoadError, SyntaxError, NoMemoryError
  # Handling all exceptions may result in masking critical errors making debugging difficult

  # Important to be intentional and specific about which exceptions to handle and what action to take
  # e.g. logging the error, sending and email to admin, displaying a message to the user


# Handling an Exceptional State


# `begin`/`rescue` block

begin
  # code at risk of failing
rescue TypeError
  # take action
end

# Will execute code on line 47 if code on line 45 raises a TypeError
# If no exception raised programme will continue to run
# If no exception type is specificed all StandardError exceptions will be rescued and handled

# It is possible to include multiple `rescue` clauses for different exceptions:

begin
  # code at risk of failing
rescue TypeError
  # action
rescue ArgumentError
  # action
end

begin
  # code at risk of failing
rescue ZeroDivisionError, TypeError
  # action
end


# Exception Objects and Built-In Methods

# Exception objects are normal Ruby objects with built-in behaviours for handling or debugging

# using an exception object - rescue any TypeError and store the exception object in `e`.

rescue TypeError => e

# Exception#message and Exception#backtrace return an error message and backtrace

begin
  # code at risk of failing
rescue StandardError => e
  puts e.message
end

# This code will rescue any StandardError including descendants and output the message associated with the exception object

# We can call `Object#class` on an exception object

# e.class
# => TypeError


# `ensure`

# Can include an `ensure` clause within `begin`/`rescue` block after the last `rescue` clause
# This branch will always execute whether an exception was raised or not
# Useful for say resource management - closing a file after use

file = open(file_name, 'w')

begin
  # do something with the file
rescue
  # handle an exception
rescue
  # handle a different exception
ensure
  file.close
  # executes every time
end

# Critical the `ensure` clause doesn't raise an exception itself


# `retry`

# Using `retry` in your `begin`/`rescue` block redirects the programme back to the `begin` statement
# Useful for a remote server
# If the code continuously fails may end up in an infinite loop
# Therefore, limit the number of times to `retry`

# Call `retry` within the `rescue` block. Elsewhere will raise a SyntaxError

RETRY_LIMIT = 5

begin
  attempts = attempts || 0
  # do something
rescue
  attempts += 1
  retry if attempts < RETRY_LIMIT
end


# Raising Exceptions Manually

# Handling an exception is a reaction to an exception that has already been raised

# Can manualy raise exceptions with `Kernel#raise`. Choose what type of exception to raise and even set your own error message
# If not specified, Ruby will default to `RuntimeError` (a sub-class of `StandardError`)

# A few syntax options:

raise TypeError.new("Something went wrong!")
raise TypeError, 'Something went wrong!'

# This will default to `RuntimeError` because no exception is specified

def validate_age(age)
  raise('invalid age') unless (0..105).include?(age)
end

# Can handle exceptions raised manually the same way

begin
  validate_age(age)
rescue RuntimeError => e
  puts e.message
  # => 'invalid age'
end


# Raising Custom Exceptions

# We can create our own custom exception classes

class ValidateAgeError < StandardError; end

# As a sub-class of an existing error, `ValidateAgeError` has access to all the built-in exception object behaviours
# Most often you'll want to inherit from StandardError

# You can give your custom exception class a descriptive name

def validate_age(age)
  raise ValidateAgeError, 'invalid age' unless (0..150).include?(age)
end

begin
  validate_age(age)
rescue ValidateAgeError => e
  puts e.message
end
