//
//  LRUBaseHashTable.swift
//  HashTable
//
//  Created by ggl on 2020/5/31.
//  Copyright © 2020 ggl. All rights reserved.
//  基于散列表的LRU缓存算法

import Foundation

/// 基于散列表的LRU缓存算法
/// 按照时间从大到小的顺序排列（最近访问的在链表尾部）

/// 链表结点结构
class DNode<K: Hashable, V> {
    /// 结点的Key值
    var key: K
    
    /// 结点的Value值
    var value: V
    
    /// 双向链表，指向前一个结点
    var prev: DNode<K, V>?
    
    /// 双向链表，指向后一个结点
    var next: DNode<K, V>?
    
    /// 散列表拉链的下一个结点
    var hNext: DNode<K, V>?
    
    init(key: K, value: V, prev: DNode<K, V>? = nil, next: DNode<K, V>? = nil, hNext: DNode<K, V>? = nil) {
        self.key = key
        self.value = value
        self.prev = prev
        self.next = next
        self.hNext = hNext
    }
}

/// 基于散列表实现的 LRU 缓存
/// 采用了散列表查询数据O(1)的性质
class LRUBaseHashTable<K: Hashable, V> {
    /// LRU 缓存默认容量大小
    private let DefaultCapcity = 10
    
    /// 散列表数组
    private var table: [DNode<K, V>?]
    
    /// 双向链表头结点
    private var head: DNode<K, V>?
    
    /// 双向链表尾结点
    private var tail: DNode<K, V>?
    
    /// LRU 缓存容量大小
    private(set) var cacheCapacity: Int
    
    /// 散列表缓存容量大小
    private var tableCapacity: Int
    
    /// 元素数量
    private(set) var count: Int = 0
    
    init(capcity: Int) {
        cacheCapacity = capcity < DefaultCapcity ? DefaultCapcity : capcity
        tableCapacity = Int(pow(2, floor(log2(Double(cacheCapacity)))))
        table = [DNode<K, V>?](repeating: nil, count: tableCapacity)
    }
    
    /// 下标操作方法
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
    
    /// 查找数据
    func value(for key: K) -> V? {
        let node = tableNode(for: key)
        if node != nil {
            linkedListMoveTail(node!)
        }
        return node?.value
    }
    
    /// 插入或者更新数据
    func update(_ value: V, for key: K) {
        let node = tableNode(for: key)
        if node == nil {
            // 表示结点不存在
            count += 1
            let newNode = DNode(key: key, value: value)
            
            // 加入到散列表中和双向链表中
            tableUpdate(newNode, for: key)
            linkedListAdd(newNode)
            
            // 判断缓存是否已满
            if count > cacheCapacity {
                // 缓存已满，需要将头结点删掉（最不经常访问的结点）
                tableRemoveNode(for: head!.key)
                linkedListRemove(head!)
            }
        } else {
            // 结点存在，需要将结点移动到尾部
            linkedListMoveTail(node!)
        }
    }
    
    /// 删除数据
    func remove(for key: K) {
        let deleteNode = tableRemoveNode(for: key)
        if deleteNode == nil {
            return
        }
        count -= 1
        linkedListRemove(deleteNode!)
    }
    
    /// 打印 LRU 缓存信息
    /// @param hashInfo 是否展示散列表信息
    func print(_ hashInfo: Bool = false) {
        // 打印双向链表信息
        Swift.print("LRU信息打印（按照访问时间从远及近顺序）：", terminator: "")
        if count == 0 {
            Swift.print("空")
            return
        }
        
        var p = head
        while p?.key != tail?.key {
            Swift.print("(\(p!.key),\(p!.value)) -> ", terminator: "")
            p = p?.next
        }
        Swift.print("(\(tail!.key),\(tail!.value))")
        
        // 打印散列表信息
        if hashInfo {
            Swift.print("散列表结构打印：")
            for (i, var node) in table.enumerated() {
                if node == nil {
                    continue
                }
                
                Swift.print("\(i): ", terminator:"")
                while node != nil {
                    Swift.print(" -> (\(node!.key),\(node!.value))", terminator: "")
                    node = node?.hNext
                }
                Swift.print("")
            }
        }
    }
}

/// 散列表相关方法
extension LRUBaseHashTable {
    /// 根据 Key 获取结点的信息
    fileprivate func tableNode(for key: K) -> DNode<K, V>? {
        // 利用 A % (2^n) = A & (2^n - 1) 原理计算要插入的位置，位运算效率更高
        let index = tableHash(key: key) & (tableCapacity - 1)
        var dNode = table[index]
        while dNode != nil {
            if key == dNode!.key {
                return dNode!
            }
            dNode = dNode!.hNext
        }
        return nil
    }
    
    /// 插入或者更新value值
    fileprivate func tableUpdate(_ node: DNode<K, V>, for key: K) {
        // 利用 A % (2^n) = A & (2^n - 1) 原理计算要插入的位置，位运算效率更高
        let hashValue = tableHash(key: key)
        let index = hashValue & (tableCapacity - 1)
        
        var p = table[index]
        if (p == nil) {
            // 头结点为空，直接插入新结点
            table[index] = node
        } else {
            // 表示待插入的位置存在元素
            if p?.key == key {
                // key值相同，替换value值
                p?.value = node.value
            } else {
                // 遍历查找更换或者新插入的位置
                while p?.hNext != nil {
                    p = p?.hNext
                    if p?.key == key {
                        p?.value = node.value
                        return
                    }
                }
                
                // 插入新结点
                p?.hNext = node
            }
        }
    }
    
    /// 根据指定的 Key 值，删除value
    @discardableResult
    fileprivate func tableRemoveNode(for key: K) -> DNode<K, V>? {
        let hashValue = tableHash(key: key)
        let index = hashValue & (tableCapacity - 1)
        
        var p = table[index]
        if p == nil {
            return nil
        }
        
        if p?.key == key {
            table[index] = table[index]?.hNext
            return p
        } else {
            while p?.hNext != nil {
                if p?.hNext?.key == key {
                    p?.hNext = p?.hNext?.hNext
                    return p?.hNext
                }
                p = p?.hNext
            }
        }
        return nil
    }
    
    /// 计算 Key 的散列值
    fileprivate func tableHash(key: K) -> Int {
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
}

/// 双向链表相关的方法
/// 缓存系统的主要操作有：添加数据、删除数据、查找数据，其中查找通过散列表来进行
extension LRUBaseHashTable {
    /// 在尾部添加结点
    fileprivate func linkedListAdd(_ node: DNode<K, V>) {
        if tail == nil {
            // 不存在任何结点
            head = node
            tail = node
        } else {
            tail?.next = node
            node.prev = tail
            tail = tail?.next
        }
    }
    
    /// 删除结点
    /// 需要注意维护头结点和尾结点的指向
    fileprivate func linkedListRemove(_ node: DNode<K, V>) {
        if head!.key == tail!.key {
            // 表示只有一个结点
            head = nil
            tail = nil
        } else if head?.key == node.key {
            // 要删除头结点
            head = node.next
            node.next?.prev = nil
            node.next = nil
        } else if tail?.key == node.key {
            // 要删除尾结点
            tail = node.prev
            node.prev?.next = nil
            node.prev = nil
        } else {
            // 要删除的是中间结点
            node.prev?.next = node.next
            node.next?.prev = node.prev
            node.prev = nil
            node.next = nil
        }
    }
    
    /// 将结点移动到尾部
    fileprivate func linkedListMoveTail(_ node: DNode<K, V>) {
        linkedListRemove(node)
        linkedListAdd(node)
    }
}
