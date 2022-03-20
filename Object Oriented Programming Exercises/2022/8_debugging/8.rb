# Task Manager

# Valentina is using a new task manager program she wrote. When interacting with her task manager, an error is raised that surprises her. Can you find the bug and fix it?

class TaskManager
  attr_reader :owner
  attr_accessor :tasks

  def initialize(owner)
    @owner = owner
    @tasks = []
  end

  def add_task(name, priority=:normal)
    task = Task.new(name, priority)
    tasks.push(task)
  end

  def complete_task(task_name)
    completed_task = nil

    tasks.each do |task|
      completed_task = task if task.name == task_name
    end

    if completed_task
      tasks.delete(completed_task)
      puts "Task '#{completed_task.name}' complete! Removed from list."
    else
      puts "Task not found."
    end
  end

  def display_all_tasks
    display(tasks)
  end

  def display_high_priority_tasks
    high_tasks = tasks.select do |task|
      task.priority == :high
    end

    display(high_tasks)
  end

  private

  def display(tasks)
    puts "--------"
    tasks.each do |task|
      puts task
    end
    puts "--------"
  end
end

class Task
  attr_accessor :name, :priority

  def initialize(name, priority=:normal)
    @name = name
    @priority = priority
  end

  def to_s
    "[" + sprintf("%-6s", priority) + "] #{name}"
  end
end

valentinas_tasks = TaskManager.new('Valentina')

valentinas_tasks.add_task('pay bills', :high)
valentinas_tasks.add_task('read OOP book')
valentinas_tasks.add_task('practice Ruby')
valentinas_tasks.add_task('run 5k', :low)

valentinas_tasks.complete_task('read OOP book')

valentinas_tasks.display_all_tasks
valentinas_tasks.display_high_priority_tasks

# NoMethodError - select called for NilClass
# tasks on row 39 refers to the local variable tasks that is being declared and assigned to rather than the @tasks instance variable

# Discussion

# When attempting to invoke the tasks getter method on line 35 in the code tasks.select, we are unintentionally referencing a local variable tasks. Since it has not yet been assigned a value, its value is nil, as reflected by the error message.

# In more detail, what happens is the following. On line 35, Ruby first has to disambiguate the tasks name on the left-hand side of the assignment operator. It could in principle be either local variable assignment, or an invocation of the setter method. In this case, Ruby interprets it as local variable assignment. Recall that if we intended to invoke the tasks= setter method, we would need to use self to disambiguate from local variable assignment (self.tasks=). Next, Ruby must disambiguate the reference to tasks on the right-hand side of the assignment operator, seen in the code tasks.select. At this point, the getter method tasks is shadowed by the local variable that was just initialized on the left side of the assignment operator. You can see this shadowing at work also in the private display method, where tasks in the method body refers to the method parameter, not the getter method.

# As a result, both references to tasks on line 35 are interpreted as a local variable. This means that we initialize a local variable, and on the same line reference it via tasks.select, before it has been assigned a value. Invoking the select method on nil caused the error we see.

# In order to disambiguate this code so that Ruby will execute it as we intend, we best give our local variable a unique name, such as high_priority_tasks. This way it does not shadow the getter method. This is also in line with the Ruby style guide, which advises to "avoid shadowing methods with local variables unless they are both equivalent."
