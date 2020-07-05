//
//  Trie.swift
//  String
//
//  Created by ggl on 2020/7/5.
//  Copyright © 2020 ggl. All rights reserved.
//  Trie树简单实现，未优化

import Foundation

class TrieNode {
    /// 存储的字符数据
    var data: Character
    /// 多个子节点，存储a~z这26个小写字母
    var children: [TrieNode?]
    /// 是否是结尾字符
    var isEndingChar = false
    
    init(data: Character) {
        self.data = data
        children = [TrieNode?](repeating: nil, count: 26)
    }
}

/// 构建Trie树的过程，需要扫描所有的字符串，时间复杂度为O(n)(n表示所有字符串的长度和)
/// 如果要查找的字符串长度为K，在Trie中查找字符串的时间复杂度是O(K)
/// Trie树非常消耗内存，为了解决这个问题我们可以稍微牺牲一点查询效率，将每个结点中的数组换成其他的数据结构，例如有序数组、跳表、散列表、红黑树等
/// Trie树的优化有很多，比如缩点优化等
/// Trie树的优缺点总结
/// 1.字符串中包含的字符集不能太大，否则存储空间要浪费很多，即使可以优化，也要付出牺牲查询、插入效率的代价
/// 2.要求字符串的前缀重合比较多，不然空间消耗会变大很多
/// 3.Trie树没有现成的数据结构来使用，需要我们自己实现数据结构，还要保证没有Bug，这个在工程上是将简单问题复杂化，除非必须，一般不建议这样做
/// 4.Trie树中用到了指针，所以对缓存并不友好，性能上会打个折扣
/// 针对在一组字符串中查找字符串的问题，我们在工程中，更倾向于用散列表或者红黑树
/// 实际上，Trie树只是不适合精确匹配查找，这种问题更适合用散列表或者红黑树来解决。Trie树比较适合的是查找前缀匹配的字符串。
class Trie {
    // 根结点不存储数据
    private var root = TrieNode(data: "/")
    
    /// 插入字符串(由a~z组成)
    /// - Parameter data: a~z组成的26个字符串
    func insert(data: String) {
        var p = root
        for i in 0..<data.count {
            // 求出字符位置（根据ascii值）
            let index = Int(data[i].asciiValue! - Character("a").asciiValue!)
            if p.children[index] == nil {
                p.children[index] = TrieNode(data: data[i])
            }
            
            // 指向子节点
            p = p.children[index]!
        }
        p.isEndingChar = true
    }
    
    /// 在Trie树中查找字符串，看字符串是否是完整路径
    /// - Parameter data: 字符串数据
    /// - Returns: 是否是完整路径
    func find(data: String) -> Bool {
        var p = root
        for i in 0..<data.count {
            let index = Int(data[i].asciiValue! - Character("a").asciiValue!)
            if p.children[index] == nil {
                return false
            }
            p = p.children[index]!
        }
        // 只是找到了前缀
        if !p.isEndingChar {
            return false
        }
        return true
    }
    
    /// 打印Trie树
    func print() {
        Swift.print("Trie树：")
        // 层级遍历，用来输出层级
        var front = 0
        var rear = 1
        var floor = 0
        
        // 层级遍历需要的队列
        var nodeQueue = [TrieNode]()
        nodeQueue.append(root)
        Swift.print("第1层:", terminator: "");
        while !nodeQueue.isEmpty {
            let node = nodeQueue.remove(at: 0)
            front += 1
            Swift.print(" \(node.data)", terminator: "")
            for child in node.children {
                if child != nil {
                    nodeQueue.append(child!)
                }
            }
            
            // 层级遍历完成
            if front == rear {
                front = 0
                rear = nodeQueue.count
                floor += 1
                
                Swift.print("")
                if rear != 0 {
                    Swift.print("第\(floor+1)层:", terminator:"")
                }
            }
        }
    }
}
