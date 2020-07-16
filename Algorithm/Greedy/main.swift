//
//  main.swift
//  Greedy
//
//  Created by ggl on 2020/7/12.
//  Copyright © 2020 ggl. All rights reserved.
//  

import Foundation

print("============贪心算法==============")
var num: UInt = 4556847594546
var removeCount: UInt = 5
let result = findMinimum(num: num, removeCount: removeCount)
print("求解 \(num) 任意移除 \(removeCount) 位数字之后的最小值为: \(result)")

num = 7639428
removeCount = 3
let result1 = findMinimum(num: num, removeCount: removeCount)
print("求解 \(num) 任意移除 \(removeCount) 位数字之后的最小值为: \(result1)")

