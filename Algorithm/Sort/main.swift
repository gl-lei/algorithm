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

// 选择排序
let selectionSortArray = selectionSort(randomArray)
print("选择排序结果：\(selectionSortArray)")

// 归并排序
let mergeSortArray = mergeSort(randomArray)
print("归并排序结果：\(mergeSortArray)")

// 快速排序
let quickSortArray = quickSort(randomArray)
print("快速排序结果：\(quickSortArray)")
