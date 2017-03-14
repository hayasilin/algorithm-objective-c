//
//  main.m
//  bubbleSort
//
//  Created by Kuan-Wei Lin on 4/25/16.
//  Copyright © 2016 Kuan-Wei Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        int i, j, t;
        
        //建立一個亂數的數字陣列
        NSMutableArray *myArray = [NSMutableArray arrayWithObjects:@8, @100, @50, @22, @15, @6, @1, @1000, @999, @0, nil];
        NSLog(@"myArray = %@", myArray);
        
        //氣泡排序的核心部分
        //myArray.count個數進行排序，只跑n-1次（因為最後比較出來的第一個數字已經被擺在最前面了，不再需要比較）
        for (i = 0; i < myArray.count - 1; i++) {
            //開始從陣列中的第一個數字跟後面的一個數字進行比較，因陣列最後一個數字後面沒數字，無法比較，所以到myArray.count的前一個數字時就停止比較
            for (j = 0; j < myArray.count - 1; j++) {
                //如果後面的數字比前面的數字大，則兩者交換，也就是列陣將會從大排到小
                if ([myArray[j] intValue] < [myArray[j + 1] intValue]) {
                    t = [myArray[j] intValue];
                    myArray[j] = myArray[j + 1];
                    myArray[j + 1] = [NSNumber numberWithInt:t];
                }
            }
            
        }
        
        NSLog(@"myArray = %@", myArray);
        for (i = 0; i < myArray.count; i++) {
            NSLog(@"分數 = %@", myArray[i]);
        }

        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
