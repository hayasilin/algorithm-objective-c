//
//  InsertionSort.m
//  Algorithm
//
//  Created by Kuan-Wei Lin on 3/8/17.
//  Copyright © 2017 TaiwanMobile. All rights reserved.
//

#import "InsertionSort.h"

@implementation InsertionSort

- (NSArray *)insertionSort:(NSArray *)array
{
    NSMutableArray *data = [array mutableCopy];
    
    for (int i = 1; i < data.count; i++)
    {
        NSNumber *temp = data[i];// tmp = 正處理的值
        
        int j;
        for(j = i ;j > 0 && temp < data[j-1]; j--)
        {
            data[j] = data[j-1];// 向右移
        }
        data[j] = temp;// 插入新值
    }
    
    return data;
}

- (NSArray *)insertionSort2:(NSArray *)array
{
    NSMutableArray *data = [array mutableCopy];
    
    for (int i = 1; i < data.count; i++)
    {
        NSNumber *temp = data[i];// tmp = 正處理的值
        int j = i - 1;

        while (j > -1 && temp < data[j])
        {
            data[j+1] = data[j];    // 向右移
            j--;
        }
        data[j+1] = temp;// 插入新值
    }
    
    return data;
}



@end
