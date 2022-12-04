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



# Comparison Methods


# The plus method


# Element setter and getter methods


