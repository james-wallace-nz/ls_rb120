# Question 1

# Ben asked Alyssa to code review the following code:

class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# Alyssa glanced over the code quickly and said - "It looks fine, except that you forgot to put the @ before balance when you refer to the balance instance variable in the body of the positive_balance? method."

# "Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an @!"

# Who is right, Ben or Alyssa, and why?

# Ben is right. Because of the `attr_reader`, a getter method is automatically created. This provides a getter instance method named `balance`, which can be called to return the @balance instance variable.

# The `positive_balance?` instance method will call the `balance` instance method, which will return the `@balance` instance variable.


# Question 2

# Alan created the following code to keep track of items for a shopping cart application he's writing:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

# Alyssa looked at the code and spotted a mistake. "This will fail when update_quantity is called", she says.

# Can you spot the mistake and how to address it?

# `update_quantity` assigns `updated_count` to a local variable `quantity`. To invoke the setter method to reassign the `@quantity` instance variable we need to change this to `self.quantity =` and change attr_reader to attr_accessor for `:quantity`. Or set `@quantity =`


# Question 3

# In the last question Alan showed Alyssa this code which keeps track of items for a shopping cart application:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# Alyssa noticed that this will fail when update_quantity is called. Since quantity is an instance variable, it must be accessed with the @quantity notation when setting it. One way to fix this is to change attr_reader to attr_accessor and change quantity to self.quantity.

# Is there anything wrong with fixing it this way?

# Changing attr_reader to attr_accessor for both `@quantity` and `@product_name` will expose a public interface to change the quantity and product name, which may not be intended.

# This allows clients of the class to change the quantity directrly (`instance.quantity = <new value>`) rather than going through the `update_quantity` method. The protections built into `update_quantity` can be circumvented.


# Question 4

# Let's practice creating an object hierarchy.

# Create a class called Greeting with a single instance method called greet that takes a string argument and prints that argument to the terminal.

class Greeting
  def greet(message)
    puts message
  end
end

# Now create two other classes that are derived from Greeting: one called Hello and one called Goodbye. The Hello class should have a hi method that takes no arguments and prints "Hello". The Goodbye class should have a bye method to say "Goodbye". Make use of the Greeting class greet method when implementing the Hello and Goodbye classes - do not use any puts in the Hello or Goodbye classes.

class Hello < Greeting
  def hi
    greet 'Hello'
  end
end

class Goodbye < Greeting
  def bye
    greet 'Goodbye'
  end
end


# Question 5

# You are given the following class that has been implemented:

class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    filling = @filling_type || 'Plain'
    glazing = @glazing ? " with #{@glazing}" : ''
    filling + glazing
  end
end

# And the following specification of expected behavior:

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  # => "Plain"

puts donut2
  # => "Vanilla"

puts donut3
  # => "Plain with sugar"

puts donut4
  # => "Plain with chocolate sprinkles"

puts donut5
  # => "Custard with icing"

# Write additional code for KrispyKreme such that the puts statements will work as specified above.


# Question 6

# If we have these two methods in the Computer class:

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# and

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    self.template
  end
end

# What is the difference in the way the code works?

# Row `9` of the first class definition invokes the `template` getter instance method created by `attr_accessor`.

# Row `9` of the second class definition calls the getter method on the object instance (`self`). There is no difference in return values of the two `show_template` instance methods.

# The getter method doesn't require `self`, unlike the setter method


# Question 7

# How could you change the method name below so that the method name is more clear and less repetitive?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def light_status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end
end

# change `light_status` to `status`

# invoke like this:

light.status
