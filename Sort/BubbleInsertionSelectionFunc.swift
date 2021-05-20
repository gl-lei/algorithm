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
    for i in 0..<sortArray.count {
        // 提前退出冒泡循环的标志位
        var flag = false
        for j in 0..<(sortArray.count - i - 1) {
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
        
        // j从有序区的最后一个元素开始
        var j = i - 1
        while j >= 0 && sortArray[j] > temp {
            sortArray[j+1] = sortArray[j]
            j -= 1
        }
        sortArray[j+1] = temp
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
    var increment = sortedArray.count
    
    // 开始进行排序
    repeat {
        increment = increment / 2
        if increment == 0 {
            increment = 1
        }
        
        // 从无序区开始
        for i in increment..<sortedArray.count {
            // 待排序的数据
            let temp = sortedArray[i]
            
            // j指向有序区的最后一个元素
            var j = i - increment
            while j >= 0 && sortedArray[j] > temp {
                sortedArray[j+increment] = sortedArray[j]
                j -= increment
            }
            
            sortedArray[j+increment] = temp
        }
    } while increment > 1
    
    return sortedArray
}

/// 选择排序 不稳定排序算法
func selectionSort(_ array: [Int]) -> [Int] {
    var sortArray = array
    for i in 0..<sortArray.count {
        // 最小值下标
        var min = i
        for j in i+1..<sortArray.count {
            if sortArray[min] > sortArray[j] {
                min = j
            }
        }
        
        // 交换数据
        if min != i {
            sortArray.swapAt(i, min)
        }
    }
    return sortArray
}
