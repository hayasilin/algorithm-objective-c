//
//  QuickSort.m
//  Algorithm
//
//  Created by Kuan-Wei Lin on 3/8/17.
//  Copyright © 2017 TaiwanMobile. All rights reserved.
//

#import "QuickSort.h"

@implementation QuickSort

- (NSArray *)quickSort:(NSArray *)array
{
    NSMutableArray *unsortedList = [array mutableCopy];
    
    NSMutableArray *lessArray = [[NSMutableArray alloc] init];
    NSMutableArray *greaterArray =[[NSMutableArray alloc] init];
    
    int quickSortCount = 0;
    
    if ([unsortedList count] < 1)
    {
        return nil;
    }
    
    int randomPivotPoint = 0;
    NSNumber *theNumber = [unsortedList objectAtIndex:randomPivotPoint];//從列陣中找一個數值當比較基準
    
    [unsortedList removeObjectAtIndex:randomPivotPoint];
    
    for (NSNumber *num in unsortedList)
    {
        quickSortCount++;
        
        if ([num doubleValue] < [theNumber doubleValue])//從小排到大，相反的話是從大排到小
        {
            [lessArray addObject:num];// 找到小於Pivot的數值
        }
        else
        {
            [greaterArray addObject:num];// 找到大於Pivot的數值
        }
    }
    
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    
    [sortedArray addObjectsFromArray:[self quickSort:lessArray]];// 對左子串列進行遞迴快速排序，並放在左邊
    [sortedArray addObject:theNumber];//加回比較基準數值
    [sortedArray addObjectsFromArray:[self quickSort:greaterArray]];// 對右子串列進行遞迴快速排序，並放在右邊
    
    return sortedArray;
}

@end
