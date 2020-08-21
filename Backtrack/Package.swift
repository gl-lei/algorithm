//
//  Package.swift
//  Backtrack
//
//  Created by ggl on 2020/8/21.
//  Copyright © 2020 ggl. All rights reserved.
//  0-1背包问题(回溯算法)

import Foundation
/** 问题描述
 * 我们有一个背包，背包总的承载重量是 Wkg。
 * 现在我们有 n 个物品，每个物品的重量不等，并且不可分割。我们现在期望选择几件物品，装载到背包中。
 * 在不超过背包所能装载重量的前提下，如何让背包中物品的总重量最大？
 *
 */

// 存储背包中物品总重量的最大值
private var maxW = Int.min

// 最终存储的物品数组
private var finalItems = [Int]()

// 递归过程中的物品数组
private var resultItems = [Int]()

/// 0-1背包问题求解
///
/// - Parameters:
///   - items: 物品数组
///   - loadBearing: 背包总的承重
func find(items: [Int], loadBearing: Int) -> (weight: Int, items: [Int]) {
    resultItems = [Int](repeating: 0, count: items.count)
    recurFind(curIndex: 0, items: items, curW: 0, loadBearing: loadBearing)
    return (maxW, finalItems)
}

/// 递归计算背包问题
///
/// - Parameters:
///   - curIndex: 当前考察到的物品的索引
///   - items: 物品数组
///   - curW: 当前物品总重量
///   - loadBearing: 背包总承重
private func recurFind(curIndex: Int, items: [Int], curW: Int, loadBearing: Int) {
    // 物品已装满或者已经考察完所有的物品了
    if curW == loadBearing || curIndex == items.count {
        if curW > maxW {
            maxW = curW
            print("背包物品: \(resultItems), 总重量: \(resultItems.reduce(0) { $0 + $1 })")
            finalItems = resultItems
        }
        return
    }
    
    // 如果未超过背包可以承受的重量，则加入背包
    if curW + items[curIndex] <= loadBearing {
        resultItems[curIndex] = items[curIndex]
        recurFind(curIndex: curIndex+1, items: items, curW: curW+items[curIndex], loadBearing: loadBearing)
    }
    
    // 加入背包的情况走完了，再走不加入背包的情况，注意不能加else，否则会漏掉很多情况
    resultItems[curIndex] = 0
    recurFind(curIndex: curIndex+1, items: items, curW: curW, loadBearing: loadBearing)
}
