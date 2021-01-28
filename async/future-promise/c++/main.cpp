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

#include <iostream>
#include <chrono>
#include <thread>
#include <future>
using namespace std::chrono_literals;
std::future<unsigned int> simulatedAsyncWork (std::chrono::milliseconds workTimeInMsec, unsigned int dataToProcess) {
    return std::async(std::launch::async,[workTimeInMsec, dataToProcess]()
    {
        std::cout<<"Doing Async Work For "<<workTimeInMsec.count()<<"ms on data "<<dataToProcess<<'\n';
        std::this_thread::sleep_for(std::chrono::milliseconds (workTimeInMsec));
        std::cout<<"Async Work Done"<<'\n';
        return dataToProcess+1;;
    });
}

void processData (unsigned int data) {
    std::future<unsigned int> processedData = simulatedAsyncWork(1000ms,data);
    processedData.wait();
    std::cout<<"Data Value After Work "<< processedData.get()<<std::endl;
}

int main() {
    processData(3);
    return 0;
}
