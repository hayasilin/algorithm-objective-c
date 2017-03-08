//
//  Factorial.m
//  Algorithm
//
//  Created by Kuan-Wei Lin on 3/8/17.
//  Copyright © 2017 TaiwanMobile. All rights reserved.
//

#import "Factorial.h"

@implementation Factorial

- (int)factorialByNumber:(int)n
{
    if (n <= 0)
    {
        return 0;
    }
    else
    {
        return n + [self factorialByNumber:(n - 1)];
    }
}

@end
