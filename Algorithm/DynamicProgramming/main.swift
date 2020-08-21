//
//  main.swift
//  DynamicProgramming
//
//  Created by ggl on 2020/8/21.
//  Copyright © 2020 ggl. All rights reserved.
//  动态规划

import Foundation

var items = [Int]()
var values = [Int]()

let count = 10
// 物品装量
for _ in 0..<count {
    let num = Int.random(in: 0...30)
    items.append(num)
}

// 物品价值
for _ in 0..<count {
    let value = Int.random(in: 0...10)
    values.append(value)
}

// 背包承重
var loadBearing = Int.random(in: 80...100)

print("============动态规划0-1背包问题，备忘录优化==============")
let packageResult = find(items: items, loadBearing: loadBearing)
print("物品: \(items)，背包承重: \(loadBearing), 最大可放入物品总重量: \(packageResult.weight), 背包物品: \(packageResult.items)")

print("\n============动态规划0-1背包问题，动态规划方式==============")
let maxWeight = knapsack(items: items, loadBearing: loadBearing)
print("物品: \(items)，背包承重: \(loadBearing), 最大可放入物品总重量: \(maxWeight)")

print("\n============动态规划0-1背包问题，动态规划方式，空间优化==============")
let maxWeight2 = knapsack2(items: items, loadBearing: loadBearing)
print("物品: \(items)，背包承重: \(loadBearing), 最大可放入物品总重量: \(maxWeight2)")

print("\n============动态规划0-1背包问题，动态规划方式，背包问题升级，输出最大价值==============")
let (weight, maxValue) = knapsack3(items: items, values: values, loadBearing: loadBearing)
print("物品: \(items), 价值: \(values), 背包承重: \(loadBearing), 重量: \(weight), 最大可放入物品总重量价值为: \(maxValue), ")



