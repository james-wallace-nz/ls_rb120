# Wish You Were Here

# On lines 37 and 38 of our code, we can see that grace and ada are located at the same coordinates. So why does line 39 output false? Fix the code to produce the expected output.

class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end

  def ==(other)
    @latitude == other.latitude && @longitude == other.longitude
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false

# ada.location and grace.location are instance objects of the GeoLocation class. These are instantiated when the location = setter is called. ada.location == grace.location is comparing the GeoLocation objects, which are different rather than the actual latitude and longitudes of those objects.

# Discussion

# On line 39 of our original code, we invoke the == method to compare the equality of two locations. Since our GeoLocation class does not implement ==, Ruby invokes the method from the BasicObject class. BasicObject#==, however, returns true only if the two objects being compared are the same object, or in other words, if they have the same object id.

# In order to compare the equality of instances of our custom class based on the value of their attributes, we need to define a == method in our custom class, which overrides BasicObject#== (thanks to Ruby's method lookup path). GeoLocation#== does exactly that: it compares two locations based on their latitude and longitude values.
