//
//  main.swift
//  BinarySearch
//
//  Created by ggl on 2019/5/19.
//  Copyright © 2019 ggl. All rights reserved.
//

import Foundation

print("=========简单二分查找=========")
let sortedArray = [8, 11, 19, 23, 27, 33, 45, 55, 67, 98]
let index = binarySearchWithSortedArray(sortedArray, value: 23)
if index != -1 {
    print("在数组中查找到值为23的元素所对应的下标为: \(index)")
} else {
    print("在数组中未查找到值为23的元素")
}

print("=========求一个数的平方根，精确到小数点后6位=========")
let num = 10
print("系统求根函数求解\(num)的平方根为：\(sqrt(Double(num)))")
let sqrtN = sqrtWithBinarySearch(num: num)
print("二分法求解\(num)的平方根为：\(sqrtN)")

let sqrtN1 = sqrtWithCalculus(num: num)
print("牛顿法求解\(num)的平方根为：\(sqrtN1)")
