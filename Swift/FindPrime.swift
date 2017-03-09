//
//  FindPrime.swift
//  test
//
//  Created by Kuan-Wei Lin on 3/8/17.
//  Copyright © 2017 Kuan-Wei Lin. All rights reserved.
//

import UIKit

class FindPrime: NSObject {
    
    func isPrime(n:Int) -> Bool!
    {
        if n <= 1
        {
            return false
        }
        
        if n <= 3
        {
            return true
        }
        
        var i = 2
        
        while i * i <= n
        {
            if n % i == 0
            {
                return false;
            }
            else
            {
                i = i + 1;
                return true;
            }
        }
        
        return false;
    }
    
    func primes(n: Int) -> [Int]
    {
        var numbers = [Int](2 ..< n)
        
        for i in 0..<n - 2
        {
            let prime = numbers[i]
            guard prime > 0 else { continue }
            for multiple in stride(from: 2 * prime - 2, to: n - 2, by: prime){
                numbers[multiple] = 0
            }
        }
        return numbers.filter{ $0 > 0 }
    }
}
