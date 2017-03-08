//
//  LinearSearch.h
//  Algorithm
//
//  Created by Kuan-Wei Lin on 3/8/17.
//  Copyright © 2017 TaiwanMobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinearSearch : NSObject

//無崗哨(衛兵)線性搜尋(Non-Sentinel Linear Search)
- (void)nonSentinelLinearSearch:(NSArray *)array key:(NSNumber *)key;

//崗哨(衛兵)線性搜尋(Sentinel Linear Serach)，在資料量很大的情況下，比無岡哨節省近一半的時間
- (void)sentinelLinearSearch:(NSArray *)array key:(NSNumber *)key;

@end
