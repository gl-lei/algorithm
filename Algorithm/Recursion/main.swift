//
//  main.swift
//  Recursion
//
//  Created by ggl on 2019/4/15.
//  Copyright © 2019年 ggl. All rights reserved.
//

import Foundation

let totalStep = 10
let res = calculateSteps(totalStep)
let res1 = calculateStepsNoRecursion(totalStep)

print(res, res1)

print("=========斐波那契数列=========")
let result = fibonacciSeries(n: 30)
print("result: \(result)")

print("=========阶乘=========")
let n = 20
let facRes = factorial(n: n)
print("\(n)的阶乘是：\(facRes)")

print("=========数据集合的全排列=========")
var array = [1, 2, 3, 4]
permutation(&array, 0, array.count-1)

