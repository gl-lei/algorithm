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
/// 完全二叉树的性质：叶子结点数 = (n + 1)/2 （n表示二叉树的结点总数）
/// 结点计算需要注意：
/// 如果堆中的数据都是从下标1开始存储的，则叶子结点范围为：n/2 + 1 ~ n（n表示结点总数 子结点下标为: 2i和2i+1 父结点下标为: i/2
/// 如果堆中的数据都是从下标0开始存储的，则叶子结点范围为：n/2 ~ n-1（n表示结点总数 子结点下标为：2i+1和2i+2 父结点下标为：(i-1)/2）

enum HeapType {
    /// 大顶堆
    case max
    
    /// 小顶堆
    case min
}

class Heap<T: Comparable> {
    /// 数组，从下标0开始存储数据
    private var arr: [T?]
    
    /// 容量
    private(set) var capacity: Int
    
    /// 已经存储的数据个数
    private(set) var count: Int
    
    /// 堆的类型
    private(set) var type: HeapType
    
    /// 堆初始化
    /// - type 堆的类型
    /// - capacity 容量大小
    init(type: HeapType = .max, capacity: Int = 16) {
        self.type = type
        self.capacity = capacity
        count = 0
        arr = [T?](repeating: nil, count: capacity)
    }
    
    /// 插入数据
    /// 当插入的数据超过容量时
    /// - 如果是大顶堆，则判断插入的数据是否比堆顶数据小，是则替换堆顶数据，重新进行堆化
    /// - 如果是小顶堆，则判断插入的数据是否比堆顶数据大，是则替换堆顶数据，重新进行堆化
    @discardableResult
    func insert(_ data: T) -> Bool {
        // 堆已经满了
        if count >= capacity {
            switch type {
            case .max:
                // 大顶堆，如果插入的数据比堆顶数据小，则插入到堆中
                if data < arr[0]! {
                    // 将首元素替换掉，然后进行堆化
                    arr[0] = data
                    heapify(index: 0)
                    return true
                }
            case .min:
                // 小顶堆，如果插入的数据比堆顶数据大，则插入到堆中
                if data > arr[0]! {
                    // 将首元素替换掉，然后进行堆化
                    arr[0] = data
                    heapify(index: 0)
                    return true
                }
            }
            return false
        }
        
        arr[count] = data
        count += 1
        
        // 当前结点索引
        var i = count-1
        // 父结点索引
        var pIndex = (i - 1) / 2
        switch type {
        case .max:
            /// 大顶堆
            while pIndex >= 0 && arr[i]! > arr[pIndex]! {
                // 交换结点位置
                arr.swapAt(i, pIndex)
                
                // 继续对比父节点
                i = pIndex
                pIndex = (i - 1) / 2
            }
        case .min:
            // 小顶堆
            while pIndex >= 0 && arr[i]! < arr[pIndex]! {
                arr.swapAt(i, pIndex)
                i = pIndex
                pIndex = (i - 1) / 2
            }
        }
        return true
    }
    
    /// 删除栈顶元素
    @discardableResult
    func remove() -> T? {
        if count == 0 {
            return nil
        }
        
        // 将最后一个元素移动到堆顶
        let res = arr[0]
        arr[0] = arr[count-1]
        count -= 1
        
        // 对第一个元素重新堆化
        heapify(index: 0)
        return res
    }
    
    /// 堆化
    /// - index: 需要堆化的元素的下标
    func heapify(index: Int) {
        var index = index
        heapifyLoop: while true {
            switch type {
            case .max:
                // 大根堆
                var maxPos = index
                
                // 判断左、右子结点与根结点的大小关系
                if index * 2 + 1 < count && arr[index]! < arr[index * 2 + 1]! {
                    maxPos = index * 2 + 1
                }
                
                if index * 2 + 2 < count && arr[maxPos]! < arr[index * 2 + 2]! {
                    maxPos = index * 2 + 2
                }
                
                // 如果根节点最大，则结束
                if maxPos == index {
                    // 结束外层while循环
                    break heapifyLoop
                }
                arr.swapAt(index, maxPos)
                index = maxPos
            case .min:
                // 小根堆
                var minPos = index
                
                // 判断左、右子结点与根结点的大小关系
                if index * 2 + 1 < count && arr[index]! > arr[index * 2 + 1]! {
                    minPos = index * 2 + 1
                }
                
                if index * 2 + 2 < count && arr[minPos]! > arr[index * 2 + 2]! {
                    minPos = index * 2 + 2
                }
                
                // 如果根节点最小，则结束循环
                if minPos == index {
                    break heapifyLoop
                }
                arr.swapAt(index, minPos)
                index = minPos
            }
        }
    }
    
    /// 打印
    func print() {
        Swift.print("堆的序列：", terminator: "")
        for i in 0..<count {
            Swift.print("\(arr[i]!) ", terminator: "")
        }
        Swift.print("")
    }
}
