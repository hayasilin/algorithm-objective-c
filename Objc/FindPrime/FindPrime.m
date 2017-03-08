//
//  FindPrime.m
//  findPrime_Objc
//
//  Created by Kuan-Wei Lin on 3/8/17.
//  Copyright © 2017 Kuan-Wei Lin. All rights reserved.
//

#import "FindPrime.h"

@implementation FindPrime

- (void)findPrimt:(int)number
{
    BOOL isPrime = YES;
    int i;
    
    for (i = 2; i < number - 1; i++)
    {
        if (number % i == 0)
        {
            isPrime = NO;
            break;
        }
    }
    
    if (isPrime)
    {
        NSLog(@"%i is prime", number);
    }
    else
    {
        NSLog(@"%i is not prime", number);
    }
}

@end
