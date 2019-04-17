//
//  MergeSortFunc.swift
//  Sort
//
//  Created by ggl on 2019/4/17.
//  Copyright © 2019 ggl. All rights reserved.
//  归并排序

import Foundation

/// 归并排序
///
/// - Parameter array: 要排序的数组
/// - Returns: 排序好之后的数组
func mergeSort(_ array: [Int]) -> [Int] {
    var sortArray = array
    mergeSortDecompose(&sortArray, p: 0, r: sortArray.count-1)
    return sortArray
}

/// 分解（分治思想）
///
/// - Parameters:
///   - array: 要排序的数组
///   - p: 数组最小下标
///   - r: 数组最大下标
func mergeSortDecompose(_ array: inout [Int], p: Int, r: Int) {
    if p >= r {
        return
    }
    
    // 递归拆分为小模块
    let q = (p + r) / 2
    mergeSortDecompose(&array, p: p, r: q)
    mergeSortDecompose(&array, p: q+1, r: r)
    
    // 将拆解完的数据合并到一起
    mergeArray(&array, p: p, mid: q, r: r)
}

/// 合并两个小模块的数据
///
/// - Parameters:
///   - array: 原始要排序的数组
///   - p: 小模块的最小下标
///   - mid: 小模块的最大下标
///   - q: 另一个小模块的最大下标
func mergeArray(_ array: inout [Int], p: Int, mid: Int, r: Int) {
    var i = p, j = mid + 1, k = 0
    
    // 临时数组，用来顺序存储两个模块中的数据，大小应为r-p+1
    var tempArray = [Int](repeating: 0, count: r-p+1)
    while i <= mid && j <= r {
        if array[i] <= array[j] {
            tempArray[k] = array[i]
            i += 1
        } else {
            tempArray[k] = array[j]
            j += 1
        }
        k += 1
    }
    
    // 将剩余的元素放入数组中
    var start = i, end = mid
    if j <= r {
        start = j
        end = r
    }
    while start <= end {
        tempArray[k] = array[start]
        k += 1
        start += 1
    }
    
    // 将临时数组中排序好的数据，复制回原数组
    array[p...r] = ArraySlice(tempArray)
}
