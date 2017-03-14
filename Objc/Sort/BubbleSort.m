//
//  BubbleSort.m
//  bubbleSort
//
//  Created by Kuan-Wei Lin on 3/14/17.
//  Copyright © 2017 Kuan-Wei Lin. All rights reserved.
//

#import "BubbleSort.h"

@implementation BubbleSort

- (NSArray *)bubbleSort:(NSArray *)array
{
    NSMutableArray *sortedArray = [NSMutableArray arrayWithArray:array];
    NSInteger sortedAboveIndex = sortedArray.count;
    
    do{
        //跑8次（總共有10個數字，但最後一個數字不用在比較一次）
        NSLog(@"sortedAboveIndex = %li", (long)sortedAboveIndex);
        int lastSwapIndex = 0;
        for (int i = 1; i < sortedAboveIndex; i ++) {
            if ([sortedArray[i - 1] integerValue] > [sortedArray[i] integerValue]) {
                [sortedArray exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
                lastSwapIndex = i;
            }
        }
        sortedAboveIndex = lastSwapIndex;
    }while (sortedAboveIndex != 0);
    
    NSLog(@"分數 = %@", sortedArray);
    
    return sortedArray;
}

@end
