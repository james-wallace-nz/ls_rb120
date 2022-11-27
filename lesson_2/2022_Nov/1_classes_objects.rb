# 1.

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

bob = Person.new('Bob')
puts bob.name
bob.name = 'Robert'
puts bob.name

puts '---'

# 2.

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

  def name
    "#{@first_name} #{@last_name}".strip
  end
end

bob = Person.new('Robert')
puts bob.name
puts bob.first_name
p bob.last_name
bob.last_name = 'Smith'
puts bob.name

puts '---'

# 3.

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    self.name = full_name
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{@first_name} #{@last_name}".strip
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new('Robert')
puts bob.name
puts bob.first_name
p bob.last_name
bob.last_name = 'Smith'
puts bob.name

bob.name = "John Adams"
puts bob.first_name
puts bob.last_name

puts '---'

# 4.

bob = Person.new("Robert Smith")
rob = Person.new("Robert Smith")

puts bob.name == rob.name

puts '---'

# 5.

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
# => <person:0130498>

puts "The person's name is: #{bob.name}"

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    self.name = full_name
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{@first_name} #{@last_name}".strip
  end

  def to_s
    name
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
# The person's name is: Robert Smith
