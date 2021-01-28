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
#import <Foundation/Foundation.h>

@interface AsyncClass : NSObject
-(NSUInteger) simulatedAsyncWork: (NSUInteger) workTimeInMsec withData:(NSUInteger) dataToProcess;
-(void) processData: (NSUInteger)  data ;

@end
@implementation AsyncClass

-(NSUInteger) simulatedAsyncWork: (NSUInteger) workTimeInMsec withData:(NSUInteger) dataToProcess  {
    NSLog(@"Doing Async Work For %lu ms on data %lu ",(unsigned long)workTimeInMsec, (unsigned long)dataToProcess);
    [NSThread sleepForTimeInterval:workTimeInMsec/1000];
    NSLog(@"Async Work Done");
    return dataToProcess+1;
}

-(void) processData: (NSUInteger)  data {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    __block NSUInteger processedData = 0;
    [queue addOperationWithBlock:^{
        processedData =  [self simulatedAsyncWork:1000 withData:data];
    }];
    [queue waitUntilAllOperationsAreFinished];
    NSLog(@"Data Value After Work: %lu ",(unsigned long)processedData);
    
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        AsyncClass * obj = [[AsyncClass alloc] init];
        [obj processData:3];
    }
    return 0;
}
