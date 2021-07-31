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
#include <future>
#include <vector>
#include <string>
#include <algorithm>

/**
 * @brief Utility function to wait for all futures in a vector to complete (are in the ready state).
 * Function returns when all futures are in the ready state
 * @param Vector of futures to wait on
 * Note this method assumes the futures are all valid
 */
template<class T>
void waitForAllFutures(const std::vector<std::future<T>> & futuresToWaitFor)
{
    for(const std::future<std::string> & futureToCheck : futuresToWaitFor){
        futureToCheck.wait();
    }
}

std::future<std::string> asyncTrim (const std::string & dataToProcess) {
    return std::async(std::launch::async,[stringToTrim = dataToProcess]() mutable
    {
        stringToTrim.erase(std::remove_if(stringToTrim.begin(), stringToTrim.end(), [](unsigned char x){return std::isspace(x);}), stringToTrim.end());
        return std::move(stringToTrim);
    });
}

void trimAllStrings ( std::vector<std::string> & stringsToTrim) {
    std::vector<std::future<std::string>> dataProcessors;
    dataProcessors.reserve(stringsToTrim.size());

    for(const std::string & stringToProcess : stringsToTrim)
    {
        std::cout<<"Removing White SpaceFor "<<stringToProcess<<std::endl;
        dataProcessors.push_back(asyncTrim(stringToProcess));
    }

    waitForAllFutures(dataProcessors);

    for(unsigned int index = 0; index < dataProcessors.size(); index++)
    {
        stringsToTrim[index] = dataProcessors[index].get();
        std::cout<<"Async Work Done Trimmed String "<<stringsToTrim[index]<<std::endl;
    }

    std::cout<<"Done With All Work"<<std::endl;

}

int main() {
    std::vector<std::string> data = {"A   A"," B BB"," C  CCC"," DD DD "};
    trimAllStrings(data);
    return 0;
}
