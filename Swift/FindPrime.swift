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
    
    //基本做法，找出該數字底下的所有數字，一個個整除比對
    func listedPrime(n:Int) -> [Int]
    {
        if n < 2
        {
            return [];
        }
        
        var isPrime: Bool?;
        var primeArray = [Int]();
        
        let list = 2...n;
        
        for i in list {
            
            isPrime = true;
            
            let jlist = 2..<i
            
            for j in jlist
            {
                if i % j == 0
                {
                    isPrime = false;
                }
            }
            
            if isPrime == true
            {
                primeArray.append(i);
            }
            
        }
        
        return primeArray;
    }
    
    //使用Swift library的做法
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
