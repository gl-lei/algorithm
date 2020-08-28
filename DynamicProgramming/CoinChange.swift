//
//  CoinChange.swift
//  DynamicProgramming
//
//  Created by ggl on 2020/8/23.
//  Copyright © 2020 ggl. All rights reserved.
//  硬币找零问题

import Foundation

/**
 * 硬币找零问题，我们在贪心算法那一节中讲过一次。我们今天来看一个新的硬币找零问题。
 * 假设我们有几种不同币值的硬币 v1，v2，……，vn（单位是元）, 如果我们要支付 w 元，求最少需要多少个硬币。
 * 比如，我们有 3 种不同的硬币，1 元、3 元、5 元，我们要支付 9 元，
 * 最少需要 3 个硬币（3 个 3 元的硬币）
 */

// 支付备忘录，防止重复计算，使用支付钱数作为Key，需要的硬币数作为Value
private var coinPayInfo = [Int: Int]()

/// 动态规划状态转移方程
/// f(n) = 1 + min(f(n-1), f(n-3), f(n-5))，n代表总共支付的钱数，f(n)代表支付n元需要的硬币个数
///
/// - Parameters:
///   - coinItems: 不同硬币类别数组(例如：1元、3元、5元就传 [1,3,5])
///   - curPay: 总共需要支付多少钱，例如9元
/// - Returns: 支付钱数所用到的最少硬币个数
func recurMinCoinChange(coinItems: [Int], curPay: Int) -> Int {
    // 需要支付0元，则直接返回
    if (curPay == 0) {
        return 0
    }
    
    // 如果需要支付的钱数小于0，表示没有硬币面值可以正好支付，返回无穷大
    if curPay < 0 {
        return Int.max
    }
    
    // 防止重复计算
    if let coinCount = coinPayInfo[curPay] {
        return coinCount
    }
    
    // 如果需要支付的钱数与硬币面值一致，则返回1
    for coin in coinItems {
        if coin == curPay {
            coinPayInfo[curPay] = 1
            return 1
        }
    }
    
    // 根据递推公式查找最小的硬币数
    var minCoinCount = [Int]()
    for coin in coinItems {
        let coinCount = recurMinCoinChange(coinItems: coinItems, curPay: curPay - coin)
        minCoinCount.append(coinCount)
    }
    
    if let min = minCoinCount.min(), min != Int.max {
        coinPayInfo[curPay] = 1 + min
        return 1 + min
    }
    
    coinPayInfo[curPay] = Int.max
    return Int.max
}

/// 动态规划求解硬币找零问题
/// 支付金额作为状态
///
/// - Parameters:
///   - coinItems: 不同硬币类别数组(例如：1元、3元、5元就传 [1,3,5])
///   - totalPay: 总共需要支付多少钱，例如9元
/// - Returns: 至少需要多个硬币，如果无法完整支付，则返回无穷大
func coinChange(coinItems: [Int], totalPay: Int) -> Int {
    // 状态数组，以存储支付的总金额(0~totalPay)作为下标，值表示当前使用到的最低硬币数。
    // 初始化为无穷大，表示无法完整支付
    var states = [Int](repeating: Int.max, count: totalPay+1)
    
    // 初始化硬币个数为1的数据(下标为0)
    for coin in coinItems {
        if coin > totalPay {
            continue
        }
        states[coin] = 1
    }
    
    // 构建其他支付钱数数值
    for i in 1...totalPay {
        if states[i] == 1 {
            continue
        }
        
        // 根据递推公式来进行计算，比如硬币数组为1，3，5，f(n)表示支付n元需要的硬币数，n表示需要支付的钱数，n需要大于0
        // f(n) = 1 + min(f(n-1), f(n-3), f(n-5))
        var countArray = [Int]()
        for coin in coinItems {
            if i - coin > 0 {
                var coinCount = states[i-coin]
                
                // 判断是否可以完整支付
                if coinCount != Int.max {
                    coinCount += 1
                }
                countArray.append(coinCount)
            }
        }
        
        // 给当前的钱数设置使用最少的金币数
        if let min = countArray.min() {
            states[i] = min
        } else {
            states[i] = Int.max
        }
    }
    
    print("硬币状态数组: \(states)")
    return states[totalPay]
}


/// 最少硬币个数
private var minCoinCount = Int.max

/// 回溯算法求解硬币找零问题，进行穷举，没有进行相应的优化
///
/// - Parameters:
///   - coinItems: 硬币数组
///   - totalPay: 总共支付金额
/// - Returns: 最少硬币个数
func coinChangeRecursion(coinItems: [Int], totalPay: Int) -> Int {
     recurCoinChange(coinItems: coinItems, totalPay: totalPay, curPay: 0, coinCount: 0)
     return minCoinCount
}

/// 内部递归计算
///
/// - Parameters:
///   - coinItems: 硬币数组
///   - totalPay: 总共支付金额
///   - curPay: 当前支付金额
///   - coinCount: 当前硬币个数
private func recurCoinChange(coinItems: [Int], totalPay: Int, curPay: Int, coinCount: Int) {
    // 支付金额超过，则返回
    if curPay > totalPay {
        return
    }
    
    if curPay == totalPay {
        if coinCount < minCoinCount {
            minCoinCount = coinCount
        }
        return
    }
    
    /// 递归检查
    for i in 0..<coinItems.count {
        recurCoinChange(coinItems: coinItems, totalPay: totalPay, curPay: curPay + coinItems[i], coinCount: coinCount + 1)
    }
}
