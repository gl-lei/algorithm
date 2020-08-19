//
//  HeapSort.swift
//  Heap
//
//  Created by ggl on 2020/6/11.
//  Copyright © 2020 ggl. All rights reserved.
//  堆排序

import Foundation

/// 堆排序
/// 数组元素下标从 0 开始
func heapSort(_ arr: inout [Int]) {
    if arr.isEmpty || arr.count == 1 {
        return
    }
    buildHeap(&arr)
    
    // 表示数组元素的最大下标
    var maxIndex = arr.count-1
    while maxIndex > 0 {
        // 将排序好的最大元素放到后面，后面的元素放到最前面
        arr.swapAt(0, maxIndex)
        maxIndex -= 1
        
        // 对剩余的元素继续进行堆化
        heapify(&arr, start: 0, end: maxIndex)
    }
}

/// 建堆
/// 采用自上往下堆化
/// 在第一个元素为0的情形中，有三个性质：
/// 性质一：索引为i的左孩子的索引是 2*i+1
/// 性质二：索引为i的右孩子的索引是 2*i+2
/// 性质三：索引为I的父节点的索引是floor((i-1)/2)
func buildHeap(_ arr: inout [Int]) {
    // 从倒数非叶子结点开始调整，小于等于arr.count/2 - 1，或者是小于 arr.count/2
    let index = arr.count/2 - 1
    for i in (0...index).reversed() {
        heapify(&arr, start: i, end: arr.count-1)
    }
}

/// 对元素进行堆化（大根堆）
///
/// - Parameters:
///   - arr: 需要进行排序的数组
///   - start: 起始下标
///   - end: 终止下标
func heapify(_ arr: inout [Int], start: Int, end: Int) {
    var index = start
    let maxIndex = end
    while true {
        var maxPos = index
        // 对比左子结点
        if index * 2 + 1 <= maxIndex && arr[index] < arr[index * 2 + 1] {
            maxPos = index * 2 + 1
        }
        
        // 对比右子结点
        if index * 2 + 2 <= maxIndex && arr[maxPos] < arr[index * 2 + 2] {
            maxPos = index * 2 + 2
        }
        
        // 满足堆的条件，不需要再进行调整
        if index == maxPos {
            break
        }
        arr.swapAt(index, maxPos)
        index = maxPos
    }
}
