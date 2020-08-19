//
//  BubbleInsertionSelectionFunc.swift
//  Sort
//
//  Created by ggl on 2019/4/16.
//  Copyright © 2019年 ggl. All rights reserved.
//  冒泡、插入、选择排序 O(n^2)

import Foundation

/// 冒泡排序 稳定排序算法
/// 有序度与逆序度，有序度表示数组中有序关系元素对的个数，满有序度：n*(n+1)/2
/// 逆序度 = 满有序度 - 有序度
func bubbleSort(_ array: [Int]) -> [Int] {
    var sortArray = array
    for i in 0..<sortArray.count - 1 {
        // 提前退出冒泡循环的标志位
        var flag = false
        for j in 0..<sortArray.count - i - 1 {
            if sortArray[j] > sortArray[j+1] {
                sortArray.swapAt(j, j+1)
                flag = true
            }
        }
        if !flag {
            // 没有数据交换，提前退出
            break
        }
    }
    return sortArray
}

/// 插入排序 稳定排序算法
func insertionSort(_ array: [Int]) -> [Int] {
    var sortArray = array
    for i in 1..<sortArray.count {
        // 要插入的数据(要排序的数据)
        let temp = sortArray[i]
        
        var index = i
        // j从有序区的最后一个元素开始
        for j in (0...i-1).reversed() {
            // 如果数大于要插入的数据，则往后挪动
            if sortArray[j] > temp {
                sortArray[j+1] = sortArray[j]
                // 记录要插入的位置
                index = j
            }
        }
        sortArray[index] = temp
    }
    return sortArray
}

/// 希尔排序
/// 希尔排序的时间复杂度与增量的选择有关，当增量为1时，希尔排序退化成了直接插入排O(N^3/2)序，时间复杂度为O(N^2)，
/// 而Hibbard增量的希尔排序时间复杂度为O(N^3/2)
///
/// - Parameter array: 要排序的数组
/// - Returns: 返回的有序数组
func shellSort(_ array: [Int]) -> [Int] {
    var sortedArray = array
    // 增量，初始设置为数组的一半
    var incrment = sortedArray.count
    
    // 开始进行排序
    repeat {
        incrment = incrment / 2
        if incrment == 0 {
            incrment = 1
        }
        
        // 从无序区开始
        for i in incrment..<sortedArray.count {
            // 待排序的数据
            let temp = sortedArray[i]
            var index = i
            
            // j从有序区的最后一个元素开始,stride(from:through:by:)方法为包括最后一个元素的值
            for j in stride(from: i-incrment, through: 0, by: -incrment) {
                if sortedArray[j] > temp {
                    sortedArray[j+incrment] = sortedArray[j]
                    index = j
                }
            }
            sortedArray[index] = temp
        }
    } while incrment > 1
    
    return sortedArray
}

/// 选择排序 不稳定排序算法
func selectionSort(_ array: [Int]) -> [Int] {
    var sortArray = array
    for i in 0..<sortArray.count-1 {
        
        // 最小值下标
        var minIndex = i
        for j in i..<sortArray.count {
            if sortArray[j] < sortArray[minIndex] {
                minIndex = j
            }
        }
        
        // 交换数据
        if minIndex != i {
            sortArray.swapAt(i, minIndex)
        }
    }
    return sortArray
}
