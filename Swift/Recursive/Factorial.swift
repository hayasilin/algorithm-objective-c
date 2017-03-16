//
//  Factorial.swift
//  Algorithm_Swift
//
//  Created by Kuan-Wei Lin on 3/16/17.
//  Copyright © 2017 cracktheterm. All rights reserved.
//

import UIKit

class Factorial: NSObject {

    func factorialByNumber(n:Int) -> Int
    {
        if n <= 0
        {
            return 0;
        }
        else
        {
            return n + factorialByNumber(n: n - 1);
        }
    }
}
