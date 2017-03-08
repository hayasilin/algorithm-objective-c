//
//  SelectionSort.m
//  Algorithm
//
//  Created by Kuan-Wei Lin on 3/8/17.
//  Copyright © 2017 TaiwanMobile. All rights reserved.
//

#import "SelectionSort.h"

@implementation SelectionSort

- (NSArray *)selectionSort:(NSArray *)array;
{
    NSMutableArray *data = [array mutableCopy];
    
    for (int i = 0; i < data.count; i++)
    {
        int min = i;
        
        for (int j = i + 1; j < data.count; j++)
        {
            if (data[j] < data[min])
            {
                min = j;
            }
        }
        
        if (i != min)
        {
            NSNumber *temp = data[i];
            data[i] = data[min];
            data[min] = temp;
        }
    }
    
    return data;
}

@end
