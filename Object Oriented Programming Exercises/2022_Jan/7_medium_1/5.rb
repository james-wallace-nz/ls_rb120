# This is one of the hardest exercises in this exercise set. It uses both exceptions and Object#send, neither of which we've discussed in detail before now. Think of this exercise as one that pushes you to learn new things on your own, and don't worry if you can't solve it.

# You may remember our Minilang language from back in the RB101-RB109 Medium exercises. We return to that language now, but this time we'll be using OOP. If you need a refresher, refer back to that exercise.

# Write a class that implements a miniature stack-and-register-based programming language that has the following commands:

# `n` Place a value n in the "register". Do not modify the stack.
# `PUSH` Push the register value on to the stack. Leave the value in the register.
# `ADD` Pops a value from the stack and adds it to the register value, storing the result in the register.
# `SUB` Pops a value from the stack and subtracts it from the register value, storing the result in the register.
# `MULT` Pops a value from the stack and multiplies it by the register value, storing the result in the register.
# `DIV` Pops a value from the stack and divides it into the register value, storing the integer result in the register.
# `MOD` Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
# `POP` Remove the topmost item from the stack and place in register
# `PRINT` Print the register value
# `All` operations are integer operations (which is only important with DIV and MOD).

# Programs will be supplied to your language method via a string passed in as an argument. Your program should produce an error if an unexpected item is present in the string, or if a required stack value is not on the stack when it should be (the stack is empty). In all error cases, no further processing should be performed on the program.

# You should initialize the register to 0.

class EmptyStack < StandardError; end

class InvalidToken < StandardError; end

class Minilang
  def initialize(program)
    @stack = []
    @register = 0
    @program = program
  end

  def eval
    instructions = @program.split
    begin
      instructions.each do |token|
        eval_token(token)
      end
    rescue EmptyStack, InvalidToken => e
      puts e.message
    end
  end

  private

  def eval_token(token)
    converted = token.to_i.to_s == token ? token.to_i : token

    case converted
    when 'PUSH' then push
    when 'ADD' then add
    when 'SUB' then sub
    when 'MULT' then mult
    when 'DIV' then div
    when 'MOD' then mod
    when 'POP' then pop
    when 'PRINT' then print
    when -Float::INFINITY..Float::INFINITY then @register = converted
    else
      raise InvalidToken, "Invalid token: #{token}"
    end
  end

  def push
    @stack.push(@register.clone)
  end

  def add
    value = @stack.pop
    raise EmptyStack, 'Empty Stack!' if value.nil?

    @register += value
  end

  def sub
    value = @stack.pop
    raise EmptyStack, 'Empty Stack!' if value.nil?

    @register -= value
  end

  def mult
    value = @stack.pop
    raise EmptyStack, 'Empty Stack!' if value.nil?

    @register *= value
  end

  def div
    value = @stack.pop
    raise EmptyStack, 'Empty Stack!' if value.nil?

    @register /= value
  end

  def mod
    value = @stack.pop
    raise EmptyStack, 'Empty Stack!' if value.nil?

    @register %= value
  end

  def pop
    value = @stack.pop
    raise EmptyStack, 'Empty Stack!' if value.nil?

    @register = value
  end

  def print
    puts @register
  end
end

# Examples:

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)


# Hint:

# For error handling, you will likely need exceptions. See the Ruby documentation for handling exceptions and for the Exception class. You may also find this blog article on Getting Started With Ruby Exceptions helpful.

# Custom exceptions are usually derived from the StandardError exception class, like so:

# class MyCustomError < StandardError; end
# You may also find Object#send to be useful when evaluating the Minilang code.

# If you have a variable str that points to a string, and you want to determine if it is a number, you can use a regular expression in an if statement, like this:

# if str =~ /\A[-+]?\d+\z/
#   puts "It's a number!"
# else
#   puts "It's not a number."
# end
# Regular expressions (regex) are very useful for string operations, but we don't cover them in any detail until RB130. If you haven't already read our book, Introduction to Regular Expressions, you may do so now, but it isn't necessary - this hint is all you need to know about regex for this problem.


#   Solution:

# require 'set'

# class MinilangError < StandardError; end
# class BadTokenError < MinilangError; end
# class EmptyStackError < MinilangError; end

# class Minilang
#   ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

#   def initialize(program)
#     @program = program
#   end

#   def eval
#     @stack = []
#     @register = 0
#     @program.split.each { |token| eval_token(token) }
#   rescue MinilangError => error
#     puts error.message
#   end

#   private

#   def eval_token(token)
#     if ACTIONS.include?(token)
#       send(token.downcase)
#     elsif token =~ /\A[-+]?\d+\z/
#       @register = token.to_i
#     else
#       raise BadTokenError, "Invalid token: #{token}"
#     end
#   end

#   def push
#     @stack.push(@register)
#   end

#   def pop
#     raise EmptyStackError, "Empty stack!" if @stack.empty?
#     @register = @stack.pop
#   end

#   def add
#     @register += pop
#   end

#   def div
#     @register /= pop
#   end

#   def mod
#     @register %= pop
#   end

#   def mult
#     @register *= pop
#   end

#   def sub
#     @register -= pop
#   end

#   def print
#     puts @register
#   end
# end

# Discussion

# In some ways, this problem is easier to solve than its procedural version, but error handling makes things a bit more complicated. We also take a somewhat different approach to performing each operation, using separate methods instead of a case.

# We start by observing that our interface, as shown in the examples, calls for a class named Minilang, and an initializer that takes our minilang program as a string input. The interface also requires an eval method to evaluate and run the program. So, we set up a class that does just this.

# The eval method first creates instance variables, @register and @stack, for use in emulating the stack and register of our language processor. Then, it iterates through all of our tokens, processing them one at a time. It also captures and reports any exceptions raised during processing.

# Both of the exceptions we can raise are defined as subclasses of the MinilangError exception class, which, in turn, is a subclass of the built-in StandardError exception class. Having MinilangError between StandardError and our two real exception classes lets us easily rescue either of the exceptions that may occur.

# eval calls our workhorse method, eval_token for each token in our program. You might, at this point, be tempted to use something like Object#respond_to? to distinguish actions that can be executed, but this isn't precise, and will likely cause unexpected behaviors. To avoid this, we instead keep a list of valid tokens in ACTIONS, and check that list for the action tokens we want. If we find one, we call the appropriate method via Object#send.

# In addition to action tokens, we also need to handle integer tokens, so we check for integer values using the regex shown, and, if we have a match, we just convert the token to an integer and stick it in our register, replacing whatever value was already there.

# If the token is neither a valid action nor an integer token, we raise a BadTokenError exception to terminate the program.

# All of the actions are implemented as very simple (mostly one-liner) methods named for each action. Each method operates on our @stack and @register instance variables, and performs the specific action requested.

# Further Exploration

# You can write minilang programs that take input values by simply interpolating values into the program string with Kernel#format. For instance,

# CENTIGRADE_TO_FAHRENHEIT =
#   '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
# # 212
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
# # 32
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval
# # -40
# This process could be simplified by passing some optional parameters to eval, and using those parameters to modify the program string.

# CENTIGRADE_TO_FAHRENHEIT =
#   '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
# minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
# minilang.eval(degrees_c: 100)
# # 212
# minilang.eval(degrees_c: 0)
# # 32
# minilang.eval(degrees_c: -40)
# # -40

# Try to implement this modification. Also, try writing other minilang programs, such as one that converts fahrenheit to centigrade, another that converts miles per hour to kilometers per hour (3 mph is approximately equal to 5 kph). Try writing a program that needs two inputs: for example, compute the area of a rectangle.

# Further Exploration 2

# We are invoking the pop method within add, div, mod, mult and sub methods instead of Array#pop with stack.pop since we want the EmptyStackError to be raised in these 5 methods when the stack is empty.

# However, you might have expected that calling pop method would alter the value of @register before it's added to the return value of stack.pop. For that reason, our solution is ambiguous -- it's not entirely clear what order Ruby will use to evaluate our code. It does work, but you have to understand completely how Ruby breaks the code down.

# For example, let's see how the add method works internally: it works as though the code were written this way:

# def add
#   new_value = @register
#   new_value += pop
#   @register = new_value
# end

# Things happen in that way since @register += pop is shorthand for @register = @register + pop. The way ruby evaluates that, it first takes the first subexpression to the right of the =, @register, and evaluates it. If @register contains, say, 5, then the expression is now equivalent to @register = 5 + pop. Now, pop gets evaluated, and that removes and returns the topmost item from the stack -- call it 7 for example. It also alters @register, but, by this time, we don't care about @register. So we're now left with @register = 5 + 7 or @register = 12.

# Can you find a better solution that doesn't suffer the same ambiguity?