//
//  MergeKSortedArray.swift
//  Heap
//
//  Created by ggl on 2020/6/13.
//  Copyright © 2020 ggl. All rights reserved.
//  合并K个有序数组

import Foundation

/// 数据结点
struct HeapNode: Comparable, CustomStringConvertible {
    /// 待排序元素
    var val: Int
    
    /// 数组索引，元素是从哪个数组中获取到的
    var i: Int
    
    /// 待排序元素在数组中的下标索引
    var j: Int
    
    static func < (lhs: HeapNode, rhs: HeapNode) -> Bool {
        return lhs.val < rhs.val
    }
    
    static func <= (lhs: HeapNode, rhs: HeapNode) -> Bool {
        return lhs.val <= rhs.val
    }
    
    var description: String {
        return "\(val)"
    }
}

/// 利用小顶堆(优先级队列)合并K个有序数组
func mergeKSortedArray(_ arr: [[Int]]) -> [Int] {
    if arr.isEmpty {
        return []
    }
    
    // 创建结果数组
    var count = 0
    var resultArr = [Int]()
    
    // 建立小顶堆
    let heap = Heap<HeapNode>(type: .min, capacity: arr.count)
    for (i, sortedArr) in arr.enumerated() {
        if !sortedArr.isEmpty {
            heap.insert(HeapNode(val: sortedArr[0], i: i, j: 0))
        }
        count += sortedArr.count
    }
    
    // 如果小顶堆中数据不为空，就一直取
    heap.print()
    while let node = heap.remove() {
        // 将数据加入到结果数组中
        resultArr.append(node.val)
        
        // 继续从此数组中取元素
        let j = node.j + 1
        let sortedArr = arr[node.i]
        if j < sortedArr.count {
            heap.insert(HeapNode(val: sortedArr[j], i: node.i, j: j))
        }
        
        // Debug信息
        if heap.count > 0 {
            heap.print()
        }
    }
    return resultArr
}
