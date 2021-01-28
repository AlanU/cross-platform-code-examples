# Copyright 2021 Alan Uthoff
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
#                                                                                                                                  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
#  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
#  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'concurrent-ruby'

def simulatedAsyncWork(workTimeInMsec, dataToProcess)
  puts "Doing Async Work For #{workTimeInMsec} ms on data #{dataToProcess}"
  sleep(workTimeInMsec/1000)
  puts 'Async Work Done'
  return dataToProcess+1
end

def processData(data)
  future = Concurrent::Future.execute { simulatedAsyncWork(1000, data) }
  processedData = future.value
  puts "Data Value After Work #{processedData}"
end

processData(3)
