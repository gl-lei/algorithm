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
    buildHeap(&arr, arr.count - 1)
    
    // 表示数组元素的最大下标
    var maxIndex = arr.count-1
    while maxIndex > 0 {
        // 将排序好的最大元素放到后面，后面的元素放到最前面
        arr.swapAt(0, maxIndex)
        maxIndex -= 1
        
        // 对剩余的元素继续进行堆化
        heapify(&arr, maxIndex, 0)
    }
}

/// 建堆
/// 采用自上往下堆化
/// - maxIndex: 数组最大下标
func buildHeap(_ arr: inout [Int], _ maxIndex: Int) {
    // 从倒数非叶子结点开始调整，n-1/2
    for i in (0...(maxIndex-1)/2).reversed() {
        heapify(&arr, maxIndex, i)
    }
}

/// 对元素进行堆化（大根堆）
/// - maxIndex: 数组的最大下标
/// - index: 需要堆化的数组下标
func heapify(_ arr: inout [Int], _ maxIndex: Int, _ index: Int) {
    var index = index
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
        
        if index == maxPos {
            break
        }
        arr.swapAt(index, maxPos)
        index = maxPos
    }
}
