//
//  DivideAndConquer.swift
//  DivideAndConquer
//
//  Created by ggl on 2020/7/16.
//  Copyright © 2020 ggl. All rights reserved.
//  分治算法

import Foundation

/// 分治算法核心思想：分而治之
/// 分治算法是一种处理问题的思想，递归是一种编程技巧。分治算法一般都比较适合用递归来实现
/// 分治算法思想并不仅限于指导编程和算法设计，它还经常用在海量数据处理的场景中（数据分片到不同机器上处理）
/// 分治算法思想举例：
/// 1.统计我国人口，要知道我国人口就要先知道每个省人口，要知道每个省人口就要知道每个市人口，要知道每个市人口就得知道每个区县人口，直到村社区
/// 然后汇总求宗人口
/// 2.采用分治思想的算法包括：
/// - 快速排序算法，合并排序算法，桶排序算法，基数排序算法，二分查找算法
/// - 利用递归树求解算法复杂度的思想，分布式数据库利用分片技术做数据处理
/// - MapReduce模型处理思想

/// 编程求出一组数据的逆序对个数

var num = 0

/// 计算数组逆序对个数
///
/// - Parameter arr: 数组
/// - Returns: 逆序对个数
func countingReversedOrderCount(arr: [Int]) -> Int {
    var arr = arr
    mergeSortCounting(arr: &arr, low: 0, high: arr.count-1)
    return num
}

///
/// - Parameters:
///   - arr: 需要求解的数组
///   - low: 数组的最小下标
///   - high: 数组的最大下标
func mergeSortCounting(arr: inout [Int], low: Int, high: Int) {
    if low >= high {
        return
    }
    let mid = (low + high) / 2
    mergeSortCounting(arr: &arr, low: low, high: mid)
    mergeSortCounting(arr: &arr, low: mid+1, high: high)
    merge(arr: &arr, low: low, mid: mid, high: high)
}

/// 合并两个有序数组并赋值回原数组
///
/// - Parameters:
///   - arr: 原数组
///   - low: 第一个有序数组的最小下标
///   - mid: 第一个有序数组的最大下标
///   - high: 第二个有序数组的最大下标
func merge(arr: inout [Int], low: Int, mid: Int, high: Int) {
    var i = low, j = mid + 1, k = 0
    var temp = [Int](repeating: 0, count: high - low + 1)
    // 合并两个有序数组
    while i <= mid && j <= high {
        if arr[i] > arr[j] {
            // 统计arr[low...mid]之间，比arr[j]大的元素个数
            num += (mid - i + 1)
            temp[k] = arr[j]
            k += 1
            j += 1
        } else {
            temp[k] = arr[i]
            k += 1
            i += 1
        }
    }
    
    // 处理剩下的
    while i <= mid {
        temp[k] = arr[i]
        k += 1
        i += 1
    }
    
    while j <= high {
        temp[k] = arr[j]
        k += 1
        j += 1
    }
    
    // 赋值到原数组
    arr[low...high] = ArraySlice(temp)
}
