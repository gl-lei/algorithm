//
//  main.swift
//  Sort
//
//  Created by ggl on 2019/4/16.
//  Copyright © 2019年 ggl. All rights reserved.
//

import Foundation

var randomArray = [Int]()
for _ in 0..<10 {
    randomArray.append(Int.random(in: 0...30))
}
print("原始随机数组：\(randomArray)")

// 冒泡排序
let bubbleSortArray = bubbleSort(randomArray)
print("冒泡排序结果：\(bubbleSortArray)")

// 插入排序
let insertionSortArray = insertionSort(randomArray)
print("插入排序结果：\(insertionSortArray)")

// 希尔排序
let shellSortArray = shellSort(randomArray)
print("希尔排序结果：\(shellSortArray)")

// 选择排序
let selectionSortArray = selectionSort(randomArray)
print("选择排序结果：\(selectionSortArray)")

// 归并排序
let mergeSortArray = mergeSort(randomArray)
print("归并排序结果：\(mergeSortArray)")

// 快速排序
let quickSortArray = quickSort(randomArray)
print("快速排序结果：\(quickSortArray)")

print("\n")
// 桶排序
var doubleRandomArray = [Double]()
for _ in 0..<10 {
    let num = Double.random(in: 0...30)
    doubleRandomArray.append(num)
}
print("桶排序原始数据：\(doubleRandomArray)")
let bucketSortArray = bucketSort(doubleRandomArray)
print("桶排序的结果：\(bucketSortArray)")

print("\n")
// 计数排序
//let countingArray = [2, 5, 3, 0, 2, 3, 0, 3]
var countingArray = [Int]()
for _ in 0..<30 {
    let num = Int.random(in: -5...10)
    countingArray.append(num)
}
print("计数排序原始数据：\(countingArray)")
let countingSortArray = countingSort(countingArray)
print("计数排序的结果：\(countingSortArray)")

// 查找一组数据的第K大元素
let kth = 3
let kNum = findKBigElement(randomArray, kth: kth)
print("数组：\(randomArray) 的第\(kth)大元素是：\(kNum)")
