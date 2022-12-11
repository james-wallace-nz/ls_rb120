# Consider the following class:

class Machine
  def start
    # self.flip_switch(:on)         # self.flip_switch(:on) is okay in Ruby 2.7 or higher
    flip_switch(:on)
  end

  def stop
    # self.flip_switch(:off))         # self.flip_switch(:on) is okay in Ruby 2.7 or higher
    flip_switch(:off)
  end

  def status
    switch
  end

  private

  attr_reader :switch
  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

light = Machine.new
puts light.status
light.start
puts light.status
light.stop
puts light.status

# Modify this class so both flip_switch and the setter method switch= are private methods.

# Discussion

# This problem is slightly trickier than it seems at first glance.

# We don't want to expose certain methods to the users of this code. Those two methods are flip_switch and the setter for @switch (as attr_writer :switch). To accomplish this task, lets make both flip_switch and attr_writer :switch private methods; that way, they can only be called from within the Machine class.

# The easy part is converting flip_switch to a private method. To do this, all we need to do is add a call to the Module#private in the class body prior to the definition of flip_switch, and we also need to remove the self. callers from the two calls to flip_switch (the caller is not necessary but is accepted when flip_switch is public, but it is prohibited when flip_switch is private).

# As of Ruby 2.7, it is now acceptable to call a private method with self, e.g., self.flip_switch.
# Where things get tricky is making the setter for switch private. The easy part is to simply move the attr_writer call for switch into the private section of the class definition. The trickier part is the call to the setter method: unlike all other private method calls, you must specify the caller when calling a setter method. If you try to remove the caller, ruby will create a local variable named switch.

# Now that we have our attr_writer and the flip_switch as private methods, the only way to set the instance variable @switch is through start and stop methods.

# Further Exploration

# Add a private getter for @switch to the Machine class, and add a method to Machine that shows how to use that getter.
