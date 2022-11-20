# Employee Management

# We have written some code for a simple employee management system. Each employee must have a unique serial number. However, when we are testing our program, an exception is raised. Fix the code so that the program works as expected without error.

class EmployeeManagementSystem
  attr_reader :employer

  def initialize(employer)
    @employer = employer
    @employees = []
  end

  def add(employee)
    if exists?(employee)
      puts "Employee serial number is already in the system."
    else
      employees.push(employee)
      puts "Employee added."
    end
  end

  alias_method :<<, :add

  def remove(employee)
    if !exists?(employee)
      puts "Employee serial number is not in the system."
    else
      employees.delete(employee)
      puts "Employee deleted."
    end
  end

  def exists?(employee)
    employees.any? { |e| e == employee }
  end

  def display_all_employees
    puts "#{employer} Employees: "

    employees.each do |employee|
      puts ""
      puts employee.to_s
    end
  end

  private

  attr_accessor :employees
end

class Employee
  attr_reader :name

  def initialize(name, serial_number)
    @name = name
    @serial_number = serial_number
  end

  def ==(other)
    serial_number == other.serial_number
  end

  def to_s
    "Name: #{name}\n" +
    "Serial No: #{abbreviated_serial_number}"
  end

  private

  def abbreviated_serial_number
    serial_number[-4..-1]
  end

  protected

  attr_reader :serial_number
end

# Example

miller_contracting = EmployeeManagementSystem.new('Miller Contracting')

becca = Employee.new('Becca', '232-4437-1932')
raul = Employee.new('Raul', '399-1007-4242')
natasha = Employee.new('Natasha', '399-1007-4242')

miller_contracting << becca     # => Employee added.
miller_contracting << raul      # => Employee added.
miller_contracting << raul      # => Employee serial number is already in the system.
miller_contracting << natasha   # => Employee serial number is already in the system.
miller_contracting.remove(raul) # => Employee deleted.
miller_contracting.add(natasha) # => Employee added.

miller_contracting.display_all_employees

# The == method defined in Employee class compares the object's serial_number to another Employee object's serial number
# However, the serial_number attribute has a private getter, so an error will be thrown when other.serial_number is invoked.

# Discussion

# Private methods cannot be invoked with an explicit caller, even inside of their own class. But on line 56, in Employee#==, we do invoke serial_number with an explicit caller (other).

# In order to make this work, we can make serial_number a protected method. Recall that from outside the class, protected methods work just like private methods. From inside the class, however, protected methods are accessible and may be invoked with an explicit caller.

# You may wish to review the relevant chapter of Launch School's Object Oriented Programming book.
