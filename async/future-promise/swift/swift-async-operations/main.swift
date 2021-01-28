/*
Copyright 2021 Alan Uthoff

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation

func simulatedAsyncWork( workTimeInMsec: UInt, withData dataToProcess: UInt ) -> UInt {
    print("Doing Async Work For \(workTimeInMsec) ms on data \(dataToProcess)")
    Thread.sleep(forTimeInterval:TimeInterval(workTimeInMsec/1000))
    print("Async Work Done")
    return dataToProcess+1
}
    
func processData( data: UInt) {
    let queue = OperationQueue()
    var processedData: UInt = 0
    queue.addOperation {
        processedData = simulatedAsyncWork(workTimeInMsec: 1000, withData: data)
    }
    queue.waitUntilAllOperationsAreFinished()
    print("Data Value After Work \(processedData)")
}

processData(data: 3)

