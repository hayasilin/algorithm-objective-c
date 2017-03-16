//
//  BinarySearch.swift
//  Algorithm_Swift
//
//  Created by Kuan-Wei Lin on 3/16/17.
//  Copyright © 2017 cracktheterm. All rights reserved.
//

import UIKit

class BinarySearch: NSObject {

    func binarySearch(array:[Int], key:Int)
    {
        var left = 0;
        var right = array.count - 1;
        var middle = 0;
        
        while left <= right
        {
            middle = (left + right) / 2;
            
            if array[middle] == key
            {
                print("result = \(middle)");
                return;
            }
            else if array[middle] < key
            {
                left = middle + 1;
            }
            else
            {
                right = middle - 1;
            }
        }
        
        print("-1 not founded")
    }
}
