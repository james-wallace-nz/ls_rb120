# Fix The Program - Expander

# What is wrong with the following code? What fix(es) would you make?

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    self.expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander

# expand is a private method so cannot be called on the object with an explicit caller. It must be called in the class on the instance.


# Discussion

# The Expander#to_s method tries to call the private #expand method with the syntax self.expand(3). This fails though, since private methods can never be called with an explicit caller, even when that caller is self. Thus, #expand must be called as expand(3).

# As of Ruby 2.7, it is now legal to call private methods with a literal self as the caller.
