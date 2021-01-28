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

using System;
using System.Threading.Tasks;

class Program
{
    static Task<uint> simulatedAsyncWork(int workTimeInMsec,uint dataToProcess,TaskCompletionSource<uint> promise)
    {            
        Task<uint> future = Task<uint>.Factory.StartNew(() => {
            Console.WriteLine("Doing Async Work For " + workTimeInMsec + "ms on data " + dataToProcess);
            Task.Delay(workTimeInMsec);
            Console.WriteLine("Async Work Done");
            return dataToProcess + 1;
        });
        return future;
    }

    static void processData(uint data)
    {
        var promise = new TaskCompletionSource<uint>();
        Task<uint> future =  simulatedAsyncWork(1000, data, promise);
        uint processedData = future.Result;
        Console.WriteLine("Data Value After Work " + processedData);
    }

    static void Main(string[] args)
    {
        processData(3);
    }
}

