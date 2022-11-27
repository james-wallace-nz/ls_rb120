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

# Further Exploration

# What are the differences between attr_reader, attr_writer, and attr_accessor? Why did we use attr_reader instead of one of the other two? Would it be okay to use one of the others? Why or why not?

# attr_reader creates getter methods, attr_writer creates setter methods, and attr_accessor creates both getter and setter methods.
# we used attr_reader because we only wanted to create a public getter method and not allow new title or author to be set.

# Instead of attr_reader, suppose you had added the following methods to this class:

# def title
#   @title
# end

# def author
#   @author
# end

# Would this change the behavior of the class in any way? If so, how? If not, why not? Can you think of any advantages of this code?

# The `title` and `author` instance methods are manual getter methods that are equivalent to the methods that `attr_reader` creates for us.
# Creating manual getter methods allows us to perform steps, such as formatting the output, that we can't do with attr_reader
