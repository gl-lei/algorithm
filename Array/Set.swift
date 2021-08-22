//
//  Set.swift
//  Array
//
//  Created by ggl on 2019/3/20.
//  Copyright © 2019 ggl. All rights reserved.
//  动态扩容的数组(无序)

import Foundation

/// Set 和 Array 是有区别的：
/// 1. Set 是无序容器，存储的元素是无序的；
/// 2. Set 不可以存储相同的元素（Hash值相同）；
/// 3. Set 访问元素效率为O(1)，比 Array 要高，是直接通过 Hash 值来定位元素位置。
///   底层存储结构与哈希表类似，但结点只存储Key值

/// Set数组中存储的结点数据结构
class Node<K: Hashable & CustomStringConvertible> {
    /// 保存结点的散列值
    var hash: Int
    
    /// 结点存储的Key值
    var key: K
    
    /// 指向链表结构的下一个结点，用来解决哈希冲突
    var next: Node<K>?
    
    init(hash: Int, key: K, next: Node<K>? = nil) {
        self.hash = hash
        self.key = key
        self.next = next
    }
}


/// Set 数组结构
class DynamicExpansionSet<K: Hashable & CustomStringConvertible> {
    /// 散列表默认长度
    private let DefaultInitialCapacity = 1 << 4
    
    /// 装载因子
    private let LoadFactor = 0.75
    
    /// 散列表数组
    private var table: [Node<K>?]
    
    /// 散列表实际元素数量
    private(set) var size: Int = 0
    
    /// 散列表容量大小
    private(set) var capacity: Int = 0
    
    convenience init() {
        self.init(capacity: 16)
    }
    
    init(capacity: Int) {
        let cap: Int = capacity < DefaultInitialCapacity ? DefaultInitialCapacity : Int(pow(2, ceil(log2(Double(capacity)))))
        table = [Node<K>?](repeating: nil, count: cap)
        self.capacity = cap
    }
    
    /// 是否包含某个对象
    func contain(_ object: K) -> Bool {
        // 利用 A % (2^n) = A & (2^n - 1) 原理计算要插入的位置，位运算效率更高
        let hashValue = hash(key: object)
        let index = hashValue & (capacity - 1)
        
        var node = table[index]
        while node != nil {
            if node!.key == object {
                return true
            }
            node = node?.next
        }
        
        return false
    }
    
    /// 增加元素
    ///
    /// - Parameter object: 要存储的元素
    func add(_ object: K) {
        // 利用 A % (2^n) = A & (2^n - 1) 原理计算要插入的位置，位运算效率更高
        let hashValue = hash(key: object)
        let index = hashValue & (capacity - 1)
        
        // 是否已经包含了对象
        var node = table[index]
        var lastNode: Node<K>? = nil
        while node != nil {
            if node!.key == object {
                return
            }
            lastNode = node
            node = node?.next
        }
        
        // 添加新对象
        let addNode = Node(hash: hashValue, key: object)
        if lastNode == nil {
            table[index] = addNode
        } else {
            lastNode?.next = addNode
        }
        size += 1
        
        // 判断是否需要扩容
        if (size >= Int(Double(capacity) * LoadFactor)) {
            resize()
        }
    }
    
    /// 删除元素
    ///
    /// - Parameter object: 删除要存储的元素
    /// - Returns: 是否成功
    @discardableResult
    func remove(_ object: K) -> Bool {
        // 利用 A % (2^n) = A & (2^n - 1) 原理计算要插入的位置，位运算效率更高
        let hashValue = hash(key: object)
        let index = hashValue & (capacity - 1)
        
        // 是否已经包含了对象
        var node = table[index]
        var preNode: Node<K>? = nil
        while node != nil {
            // 查找到对象，进行删除
            if node!.key == object {
                preNode?.next = node?.next
                size -= 1
                return true
            }
            preNode = node
            node = node?.next
        }
        
        return false
    }
    
    /// 扩容，扩容为原来的2倍，详细说明搜索【HashMap底层实现原理】
    func resize() {
        Swift.print("Set列表进行扩容操作")
        let oldTable = table
        let oldCapacity = capacity
        
        // 扩容为原来的两倍
        table = [Node<K>?](repeating: nil, count: capacity * 2)
        capacity *= 2
        
        // 遍历整个旧的散列表
        for (i, var node) in oldTable.enumerated() {
            if node == nil {
                continue
            }
            
            // 拉链如果只是单个结点，直接在新表中进行定位
            if node?.next == nil {
                table[node!.hash & (capacity-1)] = node
            } else {
                // 如果是多个结点，则需要 rehash 操作（因为哈希表容量变了）
                // 相同 hash 值在一个拉链上的数据，在新散列表中的位置分成两个位置，原位置和原位置 + capcity新位置，原理如下
                // 数组长度变为原来的2倍，表现在二进制上就是多了一个高位参与数组下标确定。
                // 此时，一个元素通过hash转换坐标的方法计算后，恰好出现一个现象：
                // 最高位是0则坐标不变，最高位是1则坐标变为“10000+原坐标”，即“原长度+原坐标”。
                // 因此，在扩容时，不需要重新计算元素的hash了，只需要判断最高位是1还是0就好了
                // 具体原理参考 JDK8 的元素迁移，HashMap 的扩容机制
                
                // 同一条拉链上的数据分成两个位置，用两组链表来存储
                var loHead: Node<K>? = nil, loTail: Node<K>? = nil
                var hiHead: Node<K>? = nil, hiTail: Node<K>? = nil
                var next: Node<K>?
                
                repeat {
                    next = node?.next
                    // 根据算法　node.hash & oldCap　判断节点位置　rehash　后是否发生改变
                    // 只需要判断结点哈希值的最高位是0还是1即可
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
    
    /// 打印元素
    func print() {
        Swift.print("当前 Set 容器元素个数\(self.size), 容量:\(self.capacity)")
        for (i, var node) in table.enumerated() {
            if node == nil {
                continue
            }
            Swift.print("[\(i)]:", terminator: "")
            while node != nil {
                Swift.print(" -> \(node!.key)", terminator: "")
                node = node?.next
            }
            Swift.print("")
        }
    }
}

