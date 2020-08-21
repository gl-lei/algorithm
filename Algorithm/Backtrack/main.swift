//
//  main.swift
//  Backtrack
//
//  Created by ggl on 2020/8/19.
//  Copyright © 2020 ggl. All rights reserved.
//  回溯算法

import Foundation
print("============回溯算法八皇后问题==============")
cal8Queens()

print("============回溯算法0-1背包问题==============")
var items = [Int]()
for _ in 0..<10 {
    let num = Int.random(in: 0...30)
    items.append(num)
}
var loadBearing = Int.random(in: 80...100)
let packageResult = find(items: items, loadBearing: loadBearing)
print("物品: \(items)，背包承重: \(loadBearing), 最大可放入物品总重量: \(packageResult.weight), 背包物品: \(packageResult.items)")
