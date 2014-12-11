# http://opalrb.org/blog/2014/05/07/promises-in-opal/
# Volt will automatically generate wrappers for you on the client side which will return a promise.
# Note that the classes on the server side use instance methods while the wrapper classes
# represent those methods as class methods
class LoggingTasks < Volt::TaskHandler
  def log(message)
    puts message
  end
end