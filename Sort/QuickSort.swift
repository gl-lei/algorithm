//
//  QuickSort.swift
//  Sort
//
//  Created by ggl on 2019/4/18.
//  Copyright © 2019年 ggl. All rights reserved.
//  快速排序

import Foundation

/// 快速排序
/// 最坏时间复杂度O(N^2)，平均时间复杂度O(N*logN)
/// 假设被排序的数据有N个数，遍历一次的时间复杂度是O(N),需要遍历多少次呢？至少log(N+1)次，最多N次
/// 快速排序是采用分治法进行遍历的，我们将其比作一棵二叉树，它需要遍历的次数就是二叉树的深度。根据二叉树的定义，它的深度至少是log(N+1)，最大是N
/// 快速排序不是稳定的排序算法
func quickSort(_ array: [Int]) -> [Int] {
    var sortArray = array
    quickSortDecompose(&sortArray, low: 0, high: sortArray.count-1)
    return sortArray
}

/// 分解（分治思想）
///
/// - Parameters:
///   - array: 要排序的数组
///   - p: 数组最小下标
///   - r: 数组最大下标
func quickSortDecompose(_ array: inout [Int], low: Int, high: Int) {
    if low < high {
        let pivotKey = partition(&array, low: low, high: high)
        quickSortDecompose(&array, low: low, high: pivotKey-1)
        quickSortDecompose(&array, low: pivotKey+1, high: high)
    }
}

/// 拆分（分治思想）
///
/// - Parameters:
///   - array: 要排序的数组
///   - low: 数组最小下标
///   - high: 数组最大下标
/// - Returns: 关键点pivotKey
func partition(_ array: inout [Int], low: Int, high: Int) -> Int {
    var i = low, j = high
    let pivotKey = array[j]
    
    while i < j {
        while i < j && array[i] <= pivotKey {
            i += 1
        }
        array[j] = array[i]
        
        while i < j && array[j] >= pivotKey {
            j -= 1
        }
        array[i] = array[j]
    }
    
    // 将pivotKey的值赋值给i或者j指向的位置（i和j此时指向同一个位置）
    array[i] = pivotKey
    return i
}
