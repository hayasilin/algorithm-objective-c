//
//  FindPrime.m
//  findPrime_Objc
//
//  Created by Kuan-Wei Lin on 3/8/17.
//  Copyright © 2017 Kuan-Wei Lin. All rights reserved.
//

#import "FindPrime.h"

@implementation FindPrime

- (void)findPrime:(int)number
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

- (NSArray *)listedPrime:(int)number
{
    NSMutableArray *primeArray = [NSMutableArray array];
    BOOL isPrime;
    
    int i, j;
    
    if (number < 2)
    {
        return nil;
    }
    
    for (i = 2; i <= number; i++)
    {
        isPrime = YES;
        
        for (j = 2; j < i; j++)
        {
            if (i % j == 0)
            {
                isPrime = NO;
            }
        }
        
        if(isPrime)
        {
            [primeArray addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    return primeArray;
}

@end
