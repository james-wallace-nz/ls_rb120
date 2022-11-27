# What will the following code print?

class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
# instantiates a new object of `Something` class and assigns it to the local variable `thing`. New object has the instance variable `data` with a value of String `Hello`.

puts Something.dupdata
# ByeBye
# => nil
# Class method dupdata returns 'byebye', which is output

puts thing.dupdata
# HelloHello
# => nil
# instance method `dupdata` retuns the value of data instance variable added to the value of data instance variable. `HelloHello` is output
