//
//  main.swift
//  Array
//
//  Created by ggl on 2019/3/20.
//  Copyright © 2019年 ggl. All rights reserved.
//

import Foundation

print("==================动态扩容数组===================")
var array = DynamicExpansionArray(capcity: 10)
for i in 1..<20 {
    array.add(num: i)
}
array.print()

array.insert(num: 30, at: 25)
array.print()

array.insert(num: 31, at: 2)
array.print()

array.remove(at: 1)
array.print()

print("\n=================动态扩容集合Set====================")
var set = DynamicExpansionSet<Int>(capacity: 10)
print("======添加1～20数字======")
for i in 1...20 {
    set.add(i)
}
set.print()

print("=====是否包含15=======")
print("\(set.contain(15))")

print("=======删除15======")
set.remove(15)
set.print()

print("\n=================合并两个有序数组====================")
let array1 = [1, 8, 9, 10, 14]
let array2 = [4, 9, 13, 20, 25]
let count = array1.count + array2.count

let sortedArray = mergeTwoSortedArray(arrOne: array1, arrOneCount: array1.count, arrTwo: array2, arrTwoCount: array2.count)
printArray(arr: sortedArray, count: count)
sortedArray.deallocate()

