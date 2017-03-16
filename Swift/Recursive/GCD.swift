//
//  GCD.swift
//  Algorithm_Swift
//
//  Created by Kuan-Wei Lin on 3/16/17.
//  Copyright © 2017 cracktheterm. All rights reserved.
//

import UIKit

class GCD: NSObject
{
    func GCD(a:Int, b:Int) -> Int
    {
        if a % b == 0
        {
            return b;
        }
        else
        {
            return GCD(a: b, b: a%b);
        }
    }
}
