//
//  SkipList.swift
//  SkipList
//
//  Created by ggl on 2019/5/29.
//  Copyright © 2019 ggl. All rights reserved.
//  跳表

import Foundation

/// 跳表的一种实现方式，采用类似矩阵的形式
/// 每一个node中都存储所有层级中的下一结点信息
/// 跳表中存储的是正整数，并且存储的是不重复的数据
class SkipList {
    
    /// 跳表的最大层级
    private static let MaxLevel = 16
    
    /// 跳表的层级
    private var levelCount = 1
    
    /// 带头链表
    private var head: Node = Node()
    
    /// 跳表的原链表(第1层)结点个数
    private var totalNodeCount = 0
    
    class Node {
        /// 链表数据
        var data = -1
        
        /// 所有层级的下一结点，比如forward[0]表示第1层的当前结点的下一结点，
        /// forward[1]表示第2层的当前结点的下一结点
        var forwards = [Node?](repeating: nil, count: MaxLevel)
    }
    
    /// 查找数据所在的结点
    ///
    /// - Parameter value: 查找的数据
    /// - Returns: 数据所在的结点
    func find(value: Int) -> Node? {
        var p: Node? = head
        // 从最高层级开始查找
        for i in (0..<levelCount).reversed() {
            while p?.forwards[i] != nil && p!.forwards[i]!.data < value {
                p = p?.forwards[i]
            }
            
            // 如果找到了，直接返回结点
            if p?.forwards[0] != nil && p!.forwards[0]!.data == value {
                return p!.forwards[0]!
            }
        }
        
        return nil
    }
    
    /// 插入新数据
    ///
    /// - Parameter value: 新结点的数据
    func insert(value: Int) {
        // 获取插入新数据的层级(0~level-1都需要插入)
        totalNodeCount += 1
        let level = randomLevel()
        
        // 创建新结点
        let newNode = Node()
        newNode.data = value
        
        // 需要插入位置的结点数组
        var update = [Node]()
        for _ in 0..<level {
            update.append(head)
        }
        
        // 遍历跳表的0~level-1层，找到需要插入位置的结点
        var p = head
        for i in (0..<levelCount).reversed() {
            // 遍历当前i层，找到合适的插入结点的位置，放入update数组中
            while p.forwards[i] != nil && p.forwards[i]!.data < value {
                p = p.forwards[i]!
            }
            
            // 更新要插入的结点位置
            if i < level {
                update[i] = p
            }
        }
        
        // 将新结点插入到跳表中
        for i in 0..<level {
            // 将需要插入结点位置的forwards数组元素复制到新结点中，层级之间相互不影响
            newNode.forwards[i] = update[i].forwards[i]
            
            // 将新结点插入到当前结点的后面
            update[i].forwards[i] = newNode
        }
        
        // 更新levelCount
        if levelCount < level {
            levelCount = level
        }
    }
    
    /// 删除数据所在的结点
    ///
    /// - Parameter value: 指定数据的结点
    func delete(value: Int) {
        var p: Node? = head
        
        var update = [Node?](repeating: nil, count: levelCount)
        
        // 从最高层开始查找
        for i in (0..<levelCount).reversed() {
            while p?.forwards[i] != nil && p!.forwards[i]!.data < value {
                p = p?.forwards[i]
            }
            
            update[i] = p
        }
        
        // 判断原链表是否存在需要删除的值
        if update[0]?.forwards[0] != nil && update[0]!.forwards[0]!.data == value {
            for (i, node) in update.enumerated().reversed() {
                if node?.forwards[i] != nil && node!.forwards[i]!.data == value {
                    node?.forwards[i] = node?.forwards[i]?.forwards[i]
                }
            }
        }
    }
    
    /// 获取需要插入的最大层级数
    ///
    /// - Returns: 获取插入数据的最大层级数
    func randomLevel() -> Int {
        if totalNodeCount < 4 {
            return 1
        }
        var maxLevel: Int = Int(log2(Double(totalNodeCount)))
        if maxLevel > SkipList.MaxLevel {
            maxLevel = SkipList.MaxLevel
        }
        return Int.random(in: 1...maxLevel)
    }
    
    /// 打印整个跳表
    func printAll() {
        var p: Node? = head
        for i in (0..<levelCount).reversed() {
            print("第\(i+1)层: ", terminator: "")
            while p?.forwards[i] != nil {
                print("\(p!.forwards[i]!.data) ", terminator: "")
                p = p?.forwards[i]
            }
            p = head
            print("")
        }
    }
}
