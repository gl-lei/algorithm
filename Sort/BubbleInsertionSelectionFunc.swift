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
                let temp = sortArray[j]
                sortArray[j] = sortArray[j+1]
                sortArray[j+1] = temp
                
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
        let temp = sortArray[i]
        
        var index = i
        for j in (1...i).reversed() {
            if temp < sortArray[j-1] {
                sortArray[j] = sortArray[j-1]
                index = j-1
                continue
            }
            break
        }
        sortArray[index] = temp
    }
    return sortArray
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
            let temp = sortArray[i]
            sortArray[i] = sortArray[minIndex]
            sortArray[minIndex] = temp
        }
    }
    return sortArray
}
