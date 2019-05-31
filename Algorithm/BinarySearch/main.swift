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

print("=========二分查找变形=========")
let binaryArray = [2, 3, 5, 6, 6, 6, 7, 8, 10]
print("模糊二分查找数组: \(binaryArray)")
let firstIndex = vagueBinarySearchFirstEqualValueWithSortedArray(binaryArray, value: 6)
print("查找第一个值等于6的元素下标为: \(firstIndex)")

let lastIndex = vagueBinarySearchLastEqualValueWithSortedArray(binaryArray, value: 6)
print("查找最后一个值等于6的元素下标为: \(lastIndex)")

print("=========循环有序数组查找=========")
let loopSortArray = [3, 4, 5, 6, 7, 8, 9, 0, 1, 2]
for _ in 1...10 {
    let searchNum = Int.random(in: 0...10)
    let loopSearchIndex = binarySearchLoopSortArrayOne(loopSortArray, value: searchNum)
    print("循环有序数组: \(loopSortArray) 查找值为:\(searchNum) 的元素下标为: \(loopSearchIndex)")
    
    let loopSearchIndex1 = binarySearchLoopSortArrayTwo(loopSortArray, value: searchNum)
    print("循环有序数组: \(loopSortArray) 查找值为:\(searchNum) 的元素下标为: \(loopSearchIndex1)")
    
    let loopSearchIndex2 = binarySearchLoopSortArrayThree(loopSortArray, value: searchNum)
    print("循环有序数组: \(loopSortArray) 查找值为:\(searchNum) 的元素下标为: \(loopSearchIndex2)")
    print("\n")
}

