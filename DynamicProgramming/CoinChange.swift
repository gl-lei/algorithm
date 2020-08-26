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

/// 动态规划求解硬币找零问题
/// 钱币个数 + 金额作为状态
///
/// - Parameters:
///   - coinItems: 不同硬币类别数组(例如：1元、3元、5元就传 [1,3,5])
///   - totalPay: 总共需要支付多少钱，例如9元
/// - Returns: 至少需要多个硬币
func coinChange(coinItems: [Int], totalPay: Int) -> Int {
    // 最大硬币个数，默认值为支付的金额
    var maxCoinCount = totalPay
    if let minValue = coinItems.min() {
        // 硬币个数为需要支付的金额除以最小硬币数，向上取整
        maxCoinCount = Int(ceil(Double(totalPay) / Double(minValue)))
    }
    
    // 状态数组，横轴存储支付的总金额(0~totalPay)，纵轴表示第几阶段(存储硬币个数，范围为(0~maxCoinCount-1))
    var states = [[Bool]](repeating: [Bool](repeating: false, count: totalPay + 1), count: maxCoinCount)
    
    // 初始化硬币个数为1的数据(下标为0)
    for coin in coinItems {
        if coin > totalPay {
            continue
        }
        states[0][coin] = true
    }
    
    // 构建其他结点数值
    for i in 1..<maxCoinCount {
        for j in 1...totalPay {
            // 判断已使用硬币数状态
            if states[i-1][j] {
                // 遍历所有硬币，将状态设置为true
                for coin in coinItems {
                    if j + coin <= totalPay {
                        states[i][j+coin] = true
                    }
                }
            }
        }
    }
    
    print("硬币状态数组=>")
    for i in 0..<maxCoinCount {
        for j in 0...totalPay {
            print(states[i][j] ? "1": "0", terminator: " ")
        }
        print("")
    }
    
    
    // 返回支付金额为totalPay，同时使用硬币最少的硬币个数
    for i in 0..<maxCoinCount {
        if states[i][totalPay] {
            return i+1
        }
    }
    
    return 0
}


/// 最少硬币个数
private var minCoinCount = Int.max

// 硬币状态映射，以钱币个数 + 金额作为Key
private var coinStateMap = [String: Bool](minimumCapacity: 10)

/// 回溯算法求解硬币找零问题
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
