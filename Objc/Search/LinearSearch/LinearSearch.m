//
//  LinearSearch.m
//  Algorithm
//
//  Created by Kuan-Wei Lin on 3/8/17.
//  Copyright © 2017 TaiwanMobile. All rights reserved.
//

#import "LinearSearch.h"

@implementation LinearSearch

- (void)nonSentinelLinearSearch:(NSArray *)array key:(NSNumber *)key
{
    NSMutableArray *data = [array mutableCopy];
    
    int index = 0;
    
    while (index < data.count)
    {
        if (data[index++] == key)
        {
            int result = index - 1;
            NSLog(@"result = %i", result);
        }
        else
        {
            NSLog(@"search result not found");
        }
    }
}

- (void)sentinelLinearSearch:(NSArray *)array key:(NSNumber *)key
{
    NSMutableArray *data = [array mutableCopy];
    
    int index = 0;
    
    [data addObject:key];
    
    while (data[index++] != key)
    {
        NSLog(@"index = %i", index);
    }
    
    [data removeLastObject];
    
    int result = (--index == data.count) ? -1 : index;
    
    NSLog(@"result = %i", result);
}


@end
