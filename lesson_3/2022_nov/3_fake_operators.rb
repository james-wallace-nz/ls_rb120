# In precendence order high to low:

# Method?     Operator                  Description
# No            ., ::                     Method, constant resolution operators

# Yes           [], []=                   Collection element getter and setter

# Yes           **                        Exponential operator

# Yes           !, ~, +@, -@              Not, complement, unary plus and minus

# Yes           *, /, %                   multiplication, division, modulo

# Yes           +, -                      addition, subtraction

# Yes           >>, >>                    right and left shift

# Yes           &                         Bitwise 'and'

# Yes           ^, |                      Bitwise exclusive 'or' and regular 'or (
#                                         inclusive or)'

# Yes           <=, <, >, >=              Less equal, less, greater, greater equal,

# Yes           <->, ==, ===, !=, =~, !~  comparison, equality, not equal, regex
#                                         pattern matching (!~ cannot be
#                                         directly defined)

# No           &&                         Logical And

# No           ||                         Logical Or

# No           .., ...                    Inclusive and Exclusive Range

# No           ? :                        Ternary

# No          =, %=, /=, -=, +=,          Assignment and shortcuts
#             |-, &=, >>=, <<=,
#             *=, &&=, ||=, **=, {        Block delimiter

# We can define methods in our classes to change their default behaviours.
# This is potentially dangerous as we have no idea what might happen if we call something that looks standard.

# `.` and `::` resolution operators `dog.bark` and `Math::PI` are operators and have the highest precedence of all operators.

# Equality Methods

# It's very useful to override the `==` operator. Defining `==` also gives us `!=` automatically.
# If you define `!=` too then an object could be equal and not equal at the same time

class Foo
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def ==(other)
    value == other.value
  end

  def !=(other)
    value == other.value
  end
end

foo1 = Foo.new(1)
foo2 = Foo.new(2)

p foo1 == foo2
# => false

p foo1 != foo2
# => false

p foo2 == foo2
# => true

p foo2 != foo2
# => true


# Comparison Methods

# Implementing comparison methods gives us nice syntax for comparing objects

class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other_person)
    age > other_person.age
  end
end

bob = Person.new('Bob', 49)
kim = Person.new('Kim', 33)

puts "Bob is older than Kim" if bob > kim
# => Bob is older than Kim

# Defining `>` doesn't automatically give us `<`


# The << and >> Shift Methods

my_array = %w(hello world)
my_array << '!!'
p my_array
# => ['hello', 'world', '!!']

# This is calling Array#<< method. Hash doesn't contain a << method

# You can implement `<<` or `>>` to do anything as they are regular instance methods

# When implementing fake operators choose some functionality that makes sense when used with special operator-like syntax

# `<<` works well when working with a class that represents a collection

# class Team
#   attr_accessor :name, :members

#   def initialize(name)
#     @name = name
#     @members = []
#   end

#   def <<(person)
#     # return if person.not_yet_18?      # guard clause
#     members.push person
#   end
# end

# cowboys = Team.new('Dallas Cowboys')
# emmit = Person.new('Emmit Smith', 46)

# cowboys << emmit
# p cowboys.members
# # => [<Person @name='Emmit Smith', @age=46>]


# The plus method

1 + 1
1.+(1) # actually a method call

# Writing a `+` method for our own objects:
# - Integer#+ ingrements the value by the value of the argument, returning a new integer
# - String#+ concatenates with argument, returning a new string
# - Array#+ concatenates with argument, returning a new array
# - Date#+ increments the date in days by value of argument, returning a new date

# => functionality of `+` should be incrementing or concatenating with the argument

class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  # def +(other_team)
  #   members + other_team.members
  # end
  # => returns an Array not Team object

  def +(other_team)
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
  end
end

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)
cowboys << Person.new("Emmitt Smith", 46)
cowboys << Person.new("Michael Irvin", 49)

niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
niners << Person.new("Jerry Rice", 52)
niners << Person.new("Deion Sanders", 47)

# How do we use the Team#+ method?

dream_team = cowboys + niners
# returns a new Array object, so dream_team is an array of Person objects

# Integer#+ returns a new Integer
# String#+ returns a new String
# Date#+ returns a new Date

# Team#+ should return a new Team

p dream_team
# =>
# <Team:0x000000012004df50 @name="Temporary Team", @members=[
    #<Person:0x000000012004e1a8 @name="Troy Aikman", @age=48>, #<Person:0x000000012004e158 @name="Emmitt Smith", @age=46>, #<Person:0x000000012004e108 @name="Michael Irvin", @age=49>, #<Person:0x000000012004e040 @name="Joe Montana", @age=59>, #<Person:0x000000012004dff0 @name="Jerry Rice", @age=52>, #<Person:0x000000012004dfa0 @name="Deion Sanders", @age=47>
# ]>


# Element setter and getter methods

my_array = %w(first second third fourth)
my_array[2]         # Ruby gives us nice syntax
# => 'third'
my_array.[](2)
# => 'third'

my_array[4] = 'fifth'
p my_array
# => ['first', 'second', 'third', 'fourth', 'fifth']

my_array.[]=(5, 'sixth')
# => ['first', 'second', 'third', 'fourth', 'fifth', 'sixth']

# Do use element getter and setter methods with our class it has to represent a collection

class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  def +(other_team)
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
  end

  def [](idx)
    members[idx]
  end

  def []=(idx, obj)
    members[idx] = obj
  end
end

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)
cowboys << Person.new("Emmitt Smith", 46)
cowboys << Person.new("Michael Irvin", 49)

# We take advantage of the fact that `members` is an array so we can push the real work to Array#[] and Array#[]= methods

p cowboys.members
# => [#<Person:0x000000011c062648 @name="Troy Aikman", @age=48>, #<Person:0x000000011c0625f8 @name="Emmitt Smith", @age=46>, #<Person:0x000000011c0625a8 @name="Michael Irvin", @age=49>]

p cowboys[1]
# => <Person @name='Emmitt Smith', 46>

cowboys[3] = Person.new("JJ", 72)
p cowboys[3]
# => <Person @name='JJ', @age=72>

# We can now do element reference and assignment using Team#[] and Team#[]=

# => We must take car eto follow conventions established in the Ruby standard library otherwise out own methods will be confusing
