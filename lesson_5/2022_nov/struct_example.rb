Pet = Struct.new('Pet', :kind, :name, :age)
asta = Pet.new('dog', 'Asta', 10)
cocoa = Pet.new('cat', 'Cocoa', 12)

p asta
p asta.kind
p asta.name
p asta.age

p cocoa
p cocoa.kind
p cocoa.name
p cocoa.age
cocoa.age = 3
p cocoa.age

# Struct equivalent to

class Pet
  attr_accessor :kind, :name, :age

  def initialize(kind, name, age)
    @kind = kind
    @name = name
    @age = age
  end
end
