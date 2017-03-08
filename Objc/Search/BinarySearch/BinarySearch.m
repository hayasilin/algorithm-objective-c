//
//  BinarySearch.m
//  Algorithm
//
//  Created by Kuan-Wei Lin on 3/8/17.
//  Copyright © 2017 TaiwanMobile. All rights reserved.
//

#import "BinarySearch.h"

@implementation BinarySearch

- (void)binarySearch:(NSArray *)array key:(NSNumber *)key
{
    NSMutableArray *data = [array mutableCopy];
    
    NSUInteger left = 0;
    NSUInteger right = data.count - 1;
    NSUInteger middele = 0;
    
    while (left <= right)
    {
        middele = (left + right) / 2;
        
        if (data[middele] == key)
        {
            NSLog(@"result = %lu", middele);
            return;
        }
        else if (data[middele] < key)
        {
            left = middele + 1;
        }
        else
        {
            right = middele - 1;
        }
    }
    
    NSLog(@"-1 not founded");
}

@end
