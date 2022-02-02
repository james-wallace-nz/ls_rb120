# 1.

# Alyssa has been assigned a task of modifying a class that was initially created to keep track of secret information. The new requirement calls for adding logging, when clients of the class attempt to access the secret data. Here is the class in its current form:


# She needs to modify it so that any access to data must result in a log entry being generated. That is, any call to the class which will result in data being returned must first call a logging class. The logging class has been supplied to Alyssa and looks like the following:

# Hint: Assume that you can modify the initialize method in SecretFile to have an instance of SecurityLogger be passed in as an additional argument. It may be helpful to review the lecture on collaborator objects for this practice problem.

class SecurityLogger
  def create_log_entry
    # ... implementation omitted ...
  end
end

class SecretFile
  def initialize(secret_data, log)
    @data = secret_data
    @log = log
  end

  def access_data
    log.create_log_entry
    data
  end

  private

  attr_reader :data
end

# solution:
# First modify the initialize method to take a SecurityLogger object as an argument and assign it to another instance variable.

# class SecretFile
#   attr_reader :data

#   def initialize(secret_data, logger)
#     @data = secret_data
#     @logger = logger
#   end
# end
# Second, Alyssa needs to remove the attr_reader and replace it with an explicit implementation of a method that returns the data instance variable. In that new method, she can add a call to the security logger.

# class SecretFile
#   def initialize(secret_data, logger)
#     @data = secret_data
#     @logger = logger
#   end

#   def data
#     @logger.create_log_entry
#     @data
#   end
# end
