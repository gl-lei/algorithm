//
//  SqrtFunc.swift
//  BinarySearch
//
//  Created by ggl on 2019/5/19.
//  Copyright © 2019 ggl. All rights reserved.
//  求一个数的平方根，要求精确到小数点后6位

import Foundation
/// 求一个数的平方根，精确到小数点后6位
///
/// - Parameter num: 需要求平方根的数
/// - Returns: 指定数的平方根
func sqrt(num: Int) -> Double {
    if num <= 0 {
        return Double.nan
    }
    
    var n = 1.0
    var result = 1.0
    while result < 0 || result >= 0.000001 {
        n -= (n*n - Double(num)) / (2*n)
        result = Double(num) - n * n
        print("n = \(n), result = \(result)")
    }
    
    print("n = \(n), result = \(result)")
    return n
}


/// 根据牛顿法（微积分公式），不断逼近求取近似值
/// z -= (z * z - x) / (2 * z)；z为近似值，x为要求平方根的数
