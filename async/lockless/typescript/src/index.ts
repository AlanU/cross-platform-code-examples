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

const asyncTrim = (dataToProcess: string):Promise<string> => {
   return new Promise<string>( resolve => {
       console.log(`Removing White SpaceFor ${dataToProcess}`)
       resolve(dataToProcess.replace(/\s+/g, ''));
    });
}

const trimAllStrings = async (stringsToTrim: string[]) => {
    let dataProcessors: Promise<string>[] = [];
    stringsToTrim.forEach((stringToProcess: string)=>{
        dataProcessors.push(asyncTrim(stringToProcess));
    })
    return await Promise.all(dataProcessors);
}

(async () =>{
    let data: string[]  = ["A   A"," B BB"," C  CCC"," DD DD "];
    data = await trimAllStrings(data);
    console.log(`Data Value After Work ${data}`);
})();