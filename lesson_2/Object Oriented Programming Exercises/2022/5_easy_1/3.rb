# Fix the Program - Books (part 1)

# Complete this program so that it produces the expected output:

class Book
  attr_reader :title, :author

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Expected output:
# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.


# %() creates an interpolated string: https://ruby-doc.org/core-3.1.0/doc/syntax/literals_rdoc.html#label-25q-3A+Non-Interpolable+String+Literals


# Further Exploration

# What are the differences between attr_reader, attr_writer, and attr_accessor? Why did we use attr_reader instead of one of the other two? Would it be okay to use one of the others? Why or why not?

# Instead of attr_reader, suppose you had added the following methods to this class:

def title
  @title
end

def author
  @author
end

# Would this change the behavior of the class in any way? If so, how? If not, why not? Can you think of any advantages of this code?


# attr_reader creates a getter method, attr_writer creates a setter method, while attr_accessor creates both a getter and a setter method for the symbols passed in as arguments.

# We used attr_reader to create a getter method for `title` and `author` becuase we didn't need a setter method for these instance variables.

# We could use attr_writer or attr_accessor, but that creates public setter methods that we may not wish to expose

# Creating manual getter methods for `title` and `author` would not change the class compared to using `attr_reader`. The advantage of manual getter and setter methods is we can run more code, such as validating inputs
