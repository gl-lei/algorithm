//
//  PackageDP.swift
//  DynamicProgramming
//
//  Created by ggl on 2020/8/21.
//  Copyright © 2020 ggl. All rights reserved.
//  0-1背包问题(动态规划)

import Foundation

/** 问题描述
 * 我们有一个背包，背包总的承载重量是 Wkg。
 * 现在我们有 n 个物品，每个物品的重量不等，并且不可分割。我们现在期望选择几件物品，装载到背包中。
 * 在不超过背包所能装载重量的前提下，如何让背包中物品的总重量最大？
 *
 * 我们把求解过程分成n个阶段，每个阶段会决策一个物品是否放到背包中，每个物品决策(放入或者不放入)完
 * 之后，背包中的物品的重量会有多种情况，也就是说，会达到多种不同状态。
 * 我们把每一层重复的状态合并，只记录不同的状态，然后基于上一层状态的集合，来推导下一层状态集合。
 */

/// 动态规划求解0-1背包问题
/// 时间复杂度为O(n*w), n表示物品个数，w表示背包可以承载的总重量
///
/// - Parameters:
///   - items: 物品数组
///   - loadBearing: 承重重量
/// - Returns: 可放入物品的最大承重
func knapsack(items: [Int], loadBearing: Int) -> Int {
    // 结点状态二维数组，x表示物品索引，y表示物品总重量
    var states = [[Bool]](repeating: [Bool](repeating: false, count: loadBearing+1), count: items.count)
    
    // 第一个物品需要特殊处理，两种情况：装入和不装入
    // 第一个物品不装入
    states[0][0] = true
    if items[0] <= loadBearing {
        // 第一个物品装入
        states[0][items[0]] = true
    }
    
    // 动态规划状态转移
    for i in 1..<items.count {
        // 不把i索引位置的物品放入背包
        for j in 0...loadBearing {
            if states[i-1][j] {
                states[i][j] = true
            }
        }
        
        // 把i索引位置的物品放入背包
        for j in 0...(loadBearing - items[i]) {
            if states[i-1][j] {
                states[i][j+items[i]] = true
            }
        }
    }
    
    // 输出结果
    for i in (0...loadBearing).reversed() {
        if states[items.count-1][i] {
            return i
        }
    }
    
    return 0
}

/// 动态规划求解0-1背包问题，空间进行优化，使用一维数组实现
/// 时间复杂度O(n*w)，空间复杂度为O(w)
///
/// - Parameters:
///   - items: 物品数组
///   - loadBearing: 承重重量
/// - Returns: 可放入物品的最大承重
func knapsack2(items: [Int], loadBearing: Int) -> Int {
    // 状态数组，使用一维数组来优化，表示当前物品决策的总重量结果
    var states = [Bool](repeating: false, count: loadBearing+1)
    
    // 第一个物品需要特殊处理，两种情况：加入或者不加入
    states[0] = true
    if items[0] <= loadBearing {
        // 加入
        states[items[0]] = true
    }
    
    // 考察所有的物品，并更新状态
    for i in 1..<items.count {
        // 把i索引位置的物品加入到背包中，需要从后往前遍历
        for j in (0...(loadBearing - items[i])).reversed() {
            // 如果当前states数组为true，则更新加入物品的重量状态，另外会继承上一物品不加入的状态（当前states数组就是上一个物品产生的状态结果）
            if states[j] {
                // 更新加入物品的状态，j表示当前背包重量，items[i]表示当前物品重量
                states[j+items[i]] = true
            }
        }
    }
    
    // 输出结果
    for i in (0...loadBearing).reversed() {
        if states[i] {
            return i
        }
    }
    
    return 0
}

/// 0-1背包问题升级
/// 我们现在引入物品价值这一变量。对于一组不同重量、不同价值、不可分割的物品，我们选择将某些物品装入背包，
/// 在满足背包最大重量限制的前提下，背包中可装入物品的总价值最大是多少呢?
/// 时间复杂度为O(n*w)，空间复杂度为O(w)，其中n是物品的数量，w是背包的最大承重重量
///
/// - Parameters:
///   - items: 物品重量数组
///   - values: 物品价值数组
///   - loadBearing: 承重重量
/// - Returns: 可放入物品的最大承重范围内，可装入物品的总价值最大是多少
func knapsack3(items: [Int], values: [Int], loadBearing: Int) -> (weight: Int, value: Int) {
    guard items.count == values.count else {
        print("物品数组与物品价值数组数量不一致！")
        return (0, 0)
    }
    // 状态数组，使用一维数组来优化，表示当前物品决策的总重量结果，值存储的为物品总价值
    var states = [Int](repeating: -1, count: loadBearing+1)
    
    // 第一个物品需要特殊处理，两种情况：加入或者不加入
    states[0] = 0
    if items[0] <= loadBearing {
        // 加入
        states[items[0]] = values[0]
    }
    
    // 考察每个物品
    for i in 1..<items.count {
        // 把i索引位置的物品加入到背包中，需要从后往前遍历
        for j in (0...(loadBearing - items[i])).reversed() {
            if states[j] >= 0 {
                // 更新加入物品的状态，j表示当前背包重量，items[i]表示当前物品重量
                states[j+items[i]] = states[j] + values[i]
            }
        }
    }
    
    // 查找价值最大的结果输出，并输出总重量
    var maxValue = states[0]
    var weight = 0
    for i in 1...loadBearing {
        if states[i] > maxValue {
            maxValue = states[i]
            weight = i
        }
    }
    return (weight, maxValue)
}

