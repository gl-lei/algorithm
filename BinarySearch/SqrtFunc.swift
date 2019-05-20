//
//  SqrtFunc.swift
//  BinarySearch
//
//  Created by ggl on 2019/5/19.
//  Copyright © 2019 ggl. All rights reserved.
//  求一个数的平方根，要求精确到小数点后6位

import Foundation

/// 求一个数的平方根，精确到小数点后6位，采用二分法求解
///
/// - Parameter num: 需要求平方根的数
/// - Returns: 指定数的平方根(精确到小数点后六位)
func sqrtWithBinarySearch(num: Int) -> Double {
    if num <= 0 {
        return Double.nan
    }
    
    return sqrtBinarySearchWithLowHighInfo(num: num, low: 1, high: Double(num))
}

/// 二分法求解一个数的平方根
///
/// - Parameters:
///   - num: 需要求解平方根的数
///   - low: 区间最小的数，从1开始
///   - high: 区间最大的数，从num开始
/// - Returns: 数的近似平方根(精确到小数点后六位)
func sqrtBinarySearchWithLowHighInfo(num: Int, low: Double, high: Double) -> Double {
    var low = low, high = high
    while low <= high {
        let mid = low + ((high - low) * 0.5)
        if mid * mid - Double(num) >= 0.000001 {
            high = mid - 0.0000001
        } else if mid * mid - Double(num) < 0 {
            low = mid + 0.0000001
        } else {
            return mid
        }
    }
    
    return Double.nan
}


/// 二分法求解一个数的平方根，通过不断的在[1~num]之间二分，逐渐逼近最终结果
/// 题目要求精确到小数点后6位，则符合规则的数需要满足是：0 <= sqrtNum * sqrtNum - Num < 0.000001
/// 除了使用二分法之外，还可以使用牛顿法来求解


/// 采用牛顿法求解一个数的平方根(微积分)
///
/// - Parameter num: 需要求解平方根的数
/// - Returns: 指定数的平方根
func sqrtWithCalculus(num: Int) -> Double {
    if num <= 0 {
        return Double.nan
    }
    
    var n = 1.0
    var result = 1.0
    while result < 0 || result >= 0.000001 {
        n -= (n*n - Double(num)) / (2*n)
        result = Double(num) - n * n
    }
    
    return n
}


/// 根据牛顿法（微积分公式），不断逼近求取近似值
/// z -= (z * z - x) / (2 * z)；z为近似值，x为要求平方根的数
