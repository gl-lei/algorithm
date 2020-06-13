//
//  SortFunc.swift
//  Sort
//
//  Created by ggl on 2019/4/19.
//  Copyright © 2019 ggl. All rights reserved.
//  编程实现O(n)时间复杂度内找到一组数据的第K大元素

import Foundation

/// 编程实现O(n)时间复杂度内找到一组数据的第K大元素
/// 例如，[4, 2, 5, 12, 3] 第三大元素就是4
///
/// - Parameters:
///   - array: 原始未排序数组
///   - kth: 第几大元素
/// - Returns: 第几大元素的值
func findKBigElement(_ array: [Int], kth: Int) -> Int {
    // 利用排序的分区思想 从大到小排序
    var sortArray = array
    let count = sortArray.count
    
    // 经过一次排序后，确定index的位置
    var index = partitionArray(&sortArray, low: 0, high: count-1)
    while index != kth-1 {
        if index > kth-1 {
            index = partitionArray(&sortArray, low: 0, high: index-1)
        } else {
            index = partitionArray(&sortArray, low: index+1, high:count-1)
        }
    }
    return sortArray[index]
}

/// 对数组进行从大到小进行划分，pivot左边的数都大于等于pivot，pivot右边的数都小于等于pivot
///
/// - Parameters:
///   - array: 要划分的数组
///   - low: 数组的最小下标
///   - high: 数组的最大下标
/// - Returns: 划分pivot的下标
func partitionArray(_ array: inout [Int], low: Int, high: Int) -> Int {
    var low = low
    var high = high
    let pivotKey = array[low]
    
    while low < high {
        while low < high && array[high] <= pivotKey {
            high -= 1
        }
        array[low] = array[high]
        
        while low < high && array[low] >= pivotKey {
            low += 1
        }
        array[high] = array[low]
    }
    array[low] = pivotKey
    return low
}

