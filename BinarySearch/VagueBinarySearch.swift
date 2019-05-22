//
//  VagueBinarySearch.swift
//  BinarySearch
//
//  Created by ggl on 2019/5/21.
//  Copyright © 2019 ggl. All rights reserved.
//  二分查找变形问题

import Foundation

/// 查找第一个值等于给定值的元素
///
/// - Parameters:
///   - sortedArray: 有序数组
///   - value: 需要查找的值
/// - Returns: 查找到的值的下标
func vagueBinarySearchFirstEqualValueWithSortedArray(_ sortedArray: [Int], value: Int) -> Int {
    var low = 0
    var high = sortedArray.count-1
    while low <= high {
        let mid = low + ((high - low) >> 1)
        if sortedArray[mid] > value {
            high = mid - 1
        } else if sortedArray[mid] < value {
            low = mid + 1
        } else {
            if mid == 0 || sortedArray[mid-1] != value {
                return mid
            }
            high = mid - 1
        }
    }
    
    return -1;
}

/// 查找最后一个值等于给定值的元素
///
/// - Parameters:
///   - sortedArray: 有序数组
///   - value: 需要查找的值
/// - Returns: 查找到的值的下标
func vagueBinarySearchLastEqualValueWithSortedArray(_ sortedArray: [Int], value: Int) -> Int {
    var low = 0
    var high = sortedArray.count - 1
    while low <= high {
        let mid = low + ((high - low) >> 1)
        if sortedArray[mid] > value {
            high = mid - 1
        } else if sortedArray[mid] < value {
            low = mid + 1
        } else {
            if mid == sortedArray.count-1 || sortedArray[mid+1] != value {
                return mid
            }
            low = mid + 1
        }
    }
    return -1;
}

/// 查找第一个大于等于给定值的元素
///
/// - Parameters:
///   - sortedArray: 有序数组
///   - value: 需要查找的值
/// - Returns: 查找到的值的下标
func vagueBinarySearchFirstGreaterThanOrEqualValueWithSortedArray(_ sortedArray: [Int], value: Int) -> Int {
    var low = 0
    var high = sortedArray.count - 1
    while low <= high {
        let mid = low + ((high - low) >> 1)
        if sortedArray[mid] < value {
            low = mid + 1
        } else {
            if mid == 0 || sortedArray[mid-1] < value {
                return mid
            }
            high = mid - 1
        }
    }
    return -1;
}

/// 查找最后一个小于等于给定值的元素
///
/// - Parameters:
///   - sortedArray: 有序数组
///   - value: 需要查找的值
/// - Returns: 查找到的值的下标
func vagueBinarySearchLastLessThanOrEqualValueWithSortedArray(_ sortedArray: [Int], value: Int) -> Int {
    var low = 0
    var high = sortedArray.count - 1
    while low <= high {
        let mid = low + ((high - low) >> 1)
        if sortedArray[mid] > value {
            high = mid - 1
        } else {
            if mid == sortedArray.count-1 || sortedArray[mid+1] <= value {
                return mid
            }
            low = mid + 1
        }
    }
    return -1;
}
