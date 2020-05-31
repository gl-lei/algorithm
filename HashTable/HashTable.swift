//
//  HashTable.swift
//  HashTable
//
//  Created by ggl on 2020/5/30.
//  Copyright © 2020 ggl. All rights reserved.
//  基于链表法实现的散列表

import Foundation

/// 链表结点结构
class Node<K: Hashable, V> {
    /// 保存结点的散列值
    var hash: Int
    
    /// 结点的Key值
    var key: K
    
    /// 结点的Value值
    var value: V
    
    /// 指向链表结构的下一结点
    var next: Node<K, V>?
    
    init(hash: Int, key: K, value: V, next: Node<K, V>? = nil) {
        self.hash = hash
        self.key = key
        self.value = value
        self.next = next
    }
}

/// 使用链表法构建散列表
class HashTable<K: Hashable, V> {
    /// 散列表默认长度
    private let DefaultInitialCapacity = 1 << 4
    
    /// 装载因子
    private let LoadFactor = 0.75
    
    /// 散列表数组
    private var table: [Node<K, V>?]
    
    /// 散列表实际元素数量
    private(set) var count: Int = 0
    
    /// 散列表容量大小
    private(set) var capacity: Int = 0
    
    convenience init() {
        self.init(capacity: 16)
    }
    
    init(capacity: Int) {
        let cap: Int = capacity < DefaultInitialCapacity ? DefaultInitialCapacity : Int(pow(2, ceil(log2(Double(capacity)))))
        table = [Node<K,V>?](repeating: nil, count: cap)
        self.capacity = cap
    }
    
    /// 下标便捷操作
    subscript(key: K) -> V? {
        get {
            return value(for: key)
        }
        set {
            if let value = newValue {
                update(value, for: key)
            } else {
                remove(for: key)
            }
        }
    }
    
    /// 根据 Key 获取 Value
    func value(for key: K) -> V? {
        // 利用 A % (2^n) = A & (2^n - 1) 原理计算要插入的位置，位运算效率更高
        let index = hash(key: key) & (capacity - 1)
        var node = table[index]
        while node != nil {
            if key == node!.key {
                return node!.value
            }
            node = node!.next
        }
        return nil
    }
    
    /// 插入或者更新value值
    func update(_ value: V, for key: K) {
        // 利用 A % (2^n) = A & (2^n - 1) 原理计算要插入的位置，位运算效率更高
        let hashValue = hash(key: key)
        let index = hashValue & (capacity - 1)
        
        var p = table[index]
        if (p == nil) {
            // 头结点为空，直接插入新结点
            table[index] = Node(hash: hashValue, key: key, value: value)
            count += 1
        } else {
            // 表示待插入的位置存在元素
            if p?.key == key {
                // key值相同，替换value值
                p?.value = value
            } else {
                // 遍历查找更换或者新插入的位置
                while p?.next != nil {
                    p = p?.next
                    if p?.key == key {
                        p?.value = value
                        return
                    }
                }
                
                // 插入新结点
                p?.next = Node(hash: hashValue, key: key, value: value)
                count += 1
            }
        }
        
        // 判断是否需要扩容
        if (count >= Int(Double(capacity) * LoadFactor)) {
            resize()
        }
    }
    
    /// 根据指定的 Key 值，删除value
    func remove(for key: K) {
        let hashValue = hash(key: key)
        let index = hashValue & (capacity - 1)
        
        var p = table[index]
        if p == nil {
            return
        }
        
        if p?.key == key {
            table[index] = table[index]?.next
            count -= 1
        } else {
            while p?.next != nil {
                if p?.next?.key == key {
                    p?.next = p?.next?.next
                    count -= 1
                    return
                }
                p = p?.next
            }
        }
    }
    
    /// 扩容，扩容为原来的2倍，并且
    /// 查看详细分析：https://my.oschina.net/u/2307589/blog/1800587
    func resize() {
        Swift.print("散列表进行扩容操作")
        let oldTable = table
        let oldCapacity = capacity
        table = [Node<K, V>?](repeating: nil, count: capacity * 2)
        capacity *= 2
        
        // 遍历整个散列表
        for (i, var node) in oldTable.enumerated() {
            if node == nil {
                continue
            }
            
            if node?.next == nil {
                // 如果是单个结点，直接在新表中进行定位
                table[node!.hash & (capacity-1)] = node
            } else {
                // 如果是多个结点，则需要 rehash 操作
                // 相同hash值得一个拉链上的数据，在新散列表中的位置分成两个位置，原位置和原位置 + capcity新位置
                // 具体分析见：https://my.oschina.net/u/2307589/blog/1800587
                var loHead: Node<K, V>? = nil, loTail: Node<K, V>? = nil
                var hiHead: Node<K, V>? = nil, hiTail: Node<K, V>? = nil
                var next: Node<K, V>?
                
                repeat {
                    next = node?.next
                    // 根据算法　node.hash & oldCap　判断节点位置　rehash　后是否发生改变
                    if (node!.hash & oldCapacity) == 0 {
                        // 在新散列表中，还是属于原来的位置表示是旧位置
                        if loTail == nil {
                            loHead = node
                        } else {
                            loTail?.next = node
                        }
                        loTail = node
                    } else {
                        // 在新散列表中的新位置：旧位置+ capacity
                        if hiTail == nil {
                            hiHead = node
                        } else {
                            hiTail?.next = node
                        }
                        hiTail = node
                    }
                    // 继续进行下次遍历
                    node = next
                } while node != nil
                
                if loTail != nil {
                    loTail?.next = nil
                    table[i] = loHead
                }
                
                if hiTail != nil {
                    // rehash 后结点新的位置一定为原来基础上加上 oldCap
                    hiTail?.next = nil
                    table[i + oldCapacity] = hiHead
                }
            }
        }
    }
    
    /// 计算 Key 的散列值
    func hash(key: K) -> Int {
        // 高低位异或，计算出来的具有高位与低位的性质
        let h: Int = key.hashValue
        if MemoryLayout<Int>.size == 32 {
            // 32位
            return (h ^ (h >> 16))
        } else {
            // 64位
            return (h ^ (h >> 32))
        }
    }
    
    /// 散列表输出
    func print() {
        Swift.print("当前散列表元素个数:\(self.count), 容量:\(self.capacity)")
        for (i, var node) in table.enumerated() {
            if node == nil {
                continue
            }
            
            Swift.print("\(i): ", terminator:"")
            while node != nil {
                Swift.print(" -> (\(node!.key),\(node!.value))", terminator: "")
                node = node?.next
            }
            Swift.print("")
        }
    }
}
