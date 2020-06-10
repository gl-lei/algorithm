//
//  Heap.swift
//  Heap
//
//  Created by ggl on 2020/6/10.
//  Copyright © 2020 ggl. All rights reserved.
//  堆

import Foundation

/// 堆的概念
/// 1.堆是一颗完全二叉树
/// 2.堆中的每一个结点值都必须大于等于（或小于等于）其子树中每个结点的值（大顶堆、小顶堆）
/// 堆的存储：由于堆是一颗完全二叉树，比较适合使用数组来进行存储，节省空间（不用存储额外左右子结点的指针）

enum HeapType {
    /// 大顶堆
    case max
    
    /// 小顶堆
    case min
}

class Heap<T: Comparable> {
    /// 数组，从下标1开始存储数据
    private var arr: [T?]
    
    /// 容量
    private var capacity: Int
    
    /// 已经存储的数据个数
    private var count: Int
    
    /// 堆的类型
    private var type: HeapType
    
    /// 堆初始化
    /// - type 堆的类型
    /// - capacity 容量大小
    init(type: HeapType = .max, capacity: Int = 16) {
        self.type = type
        self.capacity = capacity
        count = 0
        arr = [T?](repeating: nil, count: capacity+1)
    }
    
    /// 插入数据
    func insert(_ data: T) -> Bool {
        // 堆已经满了
        if count >= capacity {
            return false
        }
        
        count += 1
        arr[count] = data
        
        var i = count
        switch type {
        case .max:
            /// 大顶堆
            while i/2 > 0 && arr[i]! > arr[i/2]! {
                // 交换结点位置
                swap(&arr[i], &arr[i/2])
                
                // 继续对比父节点
                i = i / 2
            }
        case .min:
            // 小顶堆
            while i/2 > 0 && arr[i]! < arr[i/2]! {
                swap(&arr[i], &arr[i/2])
                i = i / 2
            }
        }
        return true
    }
    
}

