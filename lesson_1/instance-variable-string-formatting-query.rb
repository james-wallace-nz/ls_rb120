class Box
   # constructor method
   def initialize(w,h)
      @width, @height = w, h
   end
   # define to_s method
   @@count = 5
   TEST = 'testing'
   def to_s
     "#{@width} #{TEST} #@height #@@count"  # string formatting of the object.
   end
end

# create an object
box = Box.new(10, 20)

# to_s method will be called in reference of string automatically.
puts "String representation of box is : #{box}"


first_name = 'James'
last_name = 'Wallace'
puts "(w:#first_name,h:#last_name)"

puts Box::TEST