//
//  LoopSortArrayFunc.swift
//  BinarySearch
//
//  Created by ggl on 2019/5/22.
//  Copyright © 2019 ggl. All rights reserved.
//  循环有序数组查找给定值的下标

import Foundation

/// 循环有序数组定义：循环有序数组是将一个有序数组切成两段，并交换位置得到引用块内容
/// 例如：3,4,5,6,7,8,9,0,1,2

/// 循环有序数组第一种进行查找的方法(O(n))
/// 找到分界下标，分成两个有序数组；判断数据在哪个区间内，做二分查找
///
/// - Parameters:
///   - loopSortArray: 循环有序数组
///   - value: 需要查找的值
/// - Returns: 找到值所在数组下标
func binarySearchLoopSortArrayOne(_ loopSortArray: [Int], value: Int) -> Int {
    if loopSortArray.count == 0 {
        return -1;
    }
    
    // 找到分界下标
    var sortMaxIndex = 0
    var sortMaxNum = loopSortArray[0]
    for (index, num) in loopSortArray.enumerated() {
        if num >= sortMaxNum {
            sortMaxIndex = index
            sortMaxNum = num
        } else {
            break
        }
    }
    
    // 判断数据在哪个数组中，进行查找
    var low = 0, high = 0
    if value < loopSortArray[0] || value > sortMaxNum {
        low = sortMaxIndex+1
        high = loopSortArray.count - 1
    } else {
        low = 0
        high = sortMaxIndex
    }
    
    return binarySearchWithLowHighInfo(loopSortArray, value: value, low: low, high: high)
}


/// 循环有序数组第二种进行查找的方法(O(n))
/// 找到最大值下标x，所有元素下标+x偏移，超过数组范围值的取模；利用偏移后的下标做二分查找；找到目标下标，再做-x偏移;
/// - Parameters:
///   - loopSortArray: 循环有序数组
///   - value: 需要查找的值
/// - Returns: 找到值所在数组下标
func binarySearchLoopSortArrayTwo(_ loopSortArray: [Int], value: Int) -> Int {
    if loopSortArray.count == 0 {
        return -1;
    }
    
    // 找到最大值下标，假设数组按照升序来排列
    var maxNumIndex = 0
    for (index, num) in loopSortArray.enumerated() {
        if num >= loopSortArray[maxNumIndex] {
            maxNumIndex = index
        } else {
            break
        }
    }
    
    // 所有元素下标+(数组总个数-最大值下标-1)偏移，超过数组长度的对数组长度取模，目的是形成有序数组
    let delta = loopSortArray.count - 1 - maxNumIndex
    var sortedArray = loopSortArray
    for i in 0..<loopSortArray.count {
        let index = (i + delta) % loopSortArray.count
        sortedArray[index] = loopSortArray[i]
    }
    
    let findIndex = binarySearchWithSortedArray(sortedArray, value: value)
    if (findIndex < 0) {
        return findIndex
    } else {
        let result = (findIndex - delta + loopSortArray.count) % loopSortArray.count
        return result;
    }
}

/// 循环有序数组的性质：以数组中间点为分区，会将数组分成一个有序数组和一个循环有序数组
/// 如果首元素小于mid，说明前半部分是有序的，后半部分是循环有序数组；
/// 如果首元素大于mid，说明前半部分是循环有序数组，后半部分是有序数组；
/// 如果目标在有序数组范围内，使用二分查找；如果目标在循环有序数组中，设定数组边界后，继续查询
/// - Parameters:
///   - loopSortArray: 循环有序数组
///   - value: 需要查找的值
/// - Returns: 找到值所在数组下标
func binarySearchLoopSortArrayThree(_ loopSortArray: [Int], value: Int) -> Int {
    if loopSortArray.count == 0 {
        return -1
    }
    
    var low = 0, high = loopSortArray.count-1
    while low <= high {
        let mid = low + ((high - low) >> 1)
        if loopSortArray[mid] == value {
            return mid
        }
        
        if loopSortArray[low] < loopSortArray[mid] {
            // 前半部分有序，后半部分循环有序
            if value == loopSortArray[low] {
                return low
            } else if value > loopSortArray[low] && value < loopSortArray[mid] {
                return binarySearchWithLowHighInfo(loopSortArray, value: value, low: low, high: mid-1)
            } else {
                low = mid + 1
            }
        } else {
            // 前半部分循环有序，后半部分有序
            if value == loopSortArray[high] {
                return high
            } else if value < loopSortArray[high] && value > loopSortArray[mid] {
                return binarySearchWithLowHighInfo(loopSortArray, value: value, low: mid+1, high: high)
            } else {
                high = mid - 1
            }
        }
    }
    
    return -1
}
