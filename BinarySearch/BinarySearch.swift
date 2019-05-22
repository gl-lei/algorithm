//
//  BinarySearch.swift
//  BinarySearch
//
//  Created by ggl on 2019/5/19.
//  Copyright © 2019 ggl. All rights reserved.
//  有序数组的二分查找算法

import Foundation

/// 有序数组的二分查找算法
///
/// - Parameters:
///   - sortedArray: 有序数组
///   - value: 需要查找的数据
/// - Returns: 查找到的数据的下标，未找到返回-1
func binarySearchWithSortedArray(_ sortedArray: [Int], value: Int) -> Int {
    let count = sortedArray.count
    if count == 0 {
        return -1
    }
    
    var low = 0, high = count-1
    while low <= high {
        let mid = (low + high) / 2
        if sortedArray[mid] == value {
            return mid
        } else if sortedArray[mid] > value {
            high = mid - 1
        } else {
            low = mid + 1
        }
    }
    
    return -1
}

/// 递归实现有序数组的二分查找算法
///
/// - Parameters:
///   - sortedArray: 有序数组
///   - value: 需要查找的数据
/// - Returns: 查找到的数据的下标，未找到返回-1
func binarySearchWithSortedArrayRecursion(_ sortedArray: [Int], value: Int) -> Int {
    return binarySearchWithLowHighInfo(sortedArray, value: value, low: 0, high: sortedArray.count-1)
}

func binarySearchWithLowHighInfo(_ sortedArray: [Int], value: Int, low: Int, high: Int) -> Int {
    if low > high {
        return -1
    }
    
    let mid = low + ((high - low) >> 1)
    if sortedArray[mid] == value {
        return mid
    } else if sortedArray[mid] > value {
        return binarySearchWithLowHighInfo(sortedArray, value: value, low: low, high: mid-1)
    } else {
        return binarySearchWithLowHighInfo(sortedArray, value: value, low: mid+1, high: high)
    }
}

/// 二分查找容易出错的地方有3个
/// 1.循环退出条件：low <= high 而不是 low < high
/// 2.mid的取值：mid=(low+high)/2写法是有问题的。如果low和high比较大的话，两者之和可能会溢出！
/// 可以把这里的除以2操作转换为位运算 low+((high-low) >> 1) 位运算速度也比较快
/// 3.low和high的更新。注意，如果直接写成low=mid或者high=mid，就可能会发生死循环

/// 二分查找的局限性
/// 1.二分查找依赖的是顺序表结构；简单点说就是数组，如果是链表结构则二分查找时间复杂度会变得很高
/// 2.二分查找针对的是有序数据；如果数据集合有频繁的插入和删除操作，要么每次插入、删除操作之后保证
/// 数据仍然有序，要么在每次二分查找之前都先进行排序。针对这种动态数据集合，无论用哪种方法，维护有序
/// 的成本都是很高的。
/// 3.数据量太小不适合二分查找；如果数据量很小，完全没有必要使用二分查找，顺序遍历就足够了，只有数据量比较大的时候
/// ，二分查找的优势才会比较明显。
/// 4.数据量太大也不适合二分查找；二分查找底层需要依赖数组这种数据结构，而数组为了支持随机访问的特性，必须要求内存
/// 的空间连续性。如果数据量过大，没有多余的连续性空间，就不能够使用二分查找了。
