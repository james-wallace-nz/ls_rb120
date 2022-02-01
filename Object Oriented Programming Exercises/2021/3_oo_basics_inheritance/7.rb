class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
cat1.color

# all ancestors:
# p Cat.ancestors
# [Cat, Animal, Object, Kernel, BasicObject]

# method lookup path for #color
# Cat, Animal
