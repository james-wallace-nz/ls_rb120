# Fix the Program - Books (part 2)

# Complete this program so that it produces the expected output:

class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
# p book.author   # nil
# p book.title    # nil
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Expected output:
# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.


# Further Exploration

# What do you think of this way of creating and initializing Book objects? (The two steps are separate.) Would it be better to create and initialize at the same time like in the previous exercise? What potential problems, if any, are introduced by separating the steps?


# It is better to initialise the book with a title and author when it is instantiated. It is unlikely that the book will have it's title or author change, so having a public setter method is unnecessary. It would allow future changes to `title` and `author` of the book that may not be intended. Without initializing a new Book object, the instance variables @title and @author will have `nil` value until these are manually set.
