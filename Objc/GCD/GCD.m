//
//  GCD.m
//  Algorithm
//
//  Created by Kuan-Wei Lin on 3/8/17.
//  Copyright © 2017 TaiwanMobile. All rights reserved.
//

#import "GCD.h"

@implementation GCD

- (int)GCD:(int)a b:(int)b
{
    if ((a % b) == 0)
    {
        return b;
    }
    else
    {
        return [self GCD:b b:(a%b)];
    }
}

@end
