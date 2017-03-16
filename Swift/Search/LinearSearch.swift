//
//  LinearSearch.swift
//  Algorithm_Swift
//
//  Created by Kuan-Wei Lin on 3/16/17.
//  Copyright © 2017 cracktheterm. All rights reserved.
//

import UIKit

class LinearSearch: NSObject {
    
    func sentinelLinearSearch(array:[Int], key:Int)
    {
        var index = 0;
        
        var data = array;
        
        data.append(key);
        
        while array[index] != key
        {
            print("index = \(index)")
            
            index += 1;
        }
        
        data.removeLast();
        
        let result = (index == data.count) ? -1 : index;
        print("result = \(result)");
    }
    
    func nonSentinelLinearSearch(array:[Int], key:Int)
    {
        var index = 0;
        
        while index < array.count
        {
            
            if array[index] == key
            {
                let result = index;
                print("result = \(result)");
            }
            else
            {
                print("search result not found");
            }
            
            index += 1
        }
    }
}
