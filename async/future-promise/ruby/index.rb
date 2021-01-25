require 'concurrent'
require 'thread'

def simulatedAsyncWork(workTimeInMsec)
  puts "Doing Async Work For #{workTimeInMsec} ms"
  sleep(workTimeInMsec/1000)
  puts "Async Work Done"
end

def asyncFunction(message)
  future = Concurrent::Future.execute { simulatedAsyncWork(1000) }
  future.wait
  puts "Message From asyncFunction: #{message}"
end

asyncFunction("Hello World")
