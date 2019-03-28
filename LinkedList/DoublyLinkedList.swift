//
//  DoublyLinkedList.swift
//  LinkedList
//
//  Created by ggl on 2019/3/28.
//  Copyright © 2019年 ggl. All rights reserved.
//  双向链表

import Foundation

class DoublyNode {
    var pre: DoublyNode?
    var next: DoublyNode?
    var data: Int = 0
    
    init(data: Int) {
        self.data = data
    }
}

class DoublyLinkedList {
    var head: DoublyNode?
    
    /// 添加结点
    ///
    /// - Parameter node: 新节点
    func addNode(_ data: Int) {
        let node = DoublyNode(data: data)
        guard let tailNode = tailNode() else {
            head = node
            return
        }
        node.pre = tailNode
        tailNode.next = node
    }
    
    @discardableResult
    func deleteNode(_ data: Int) -> Bool {
        var curNode = head
        // 链表是否为空
        if curNode == nil {
            return false
        }
        
        // 链表头结点是否等于指定的结点
        if curNode!.data == data {
            curNode?.pre = nil
            head = curNode?.next
            head?.pre = nil
            return true
        }
        
        while curNode!.next != nil {
            curNode = curNode?.next
            
            // 比对结点的数据是否相同
            if curNode!.data == data {
                curNode?.pre?.next = curNode?.next
                curNode?.pre = nil
                return true
            }
        }
        return false
    }
    
    /// 获取链表的最后一个结点
    ///
    /// - Returns: 尾结点
    func tailNode() -> DoublyNode? {
        guard var tailNode = head else {
            return nil
        }
        
        while tailNode.next != nil {
            tailNode = tailNode.next!
        }
        return tailNode
    }
    
    /// 打印链表
    func print() {
        var curNode = head
        while curNode != nil {
            if curNode?.next == nil {
                Swift.print(curNode!.data)
                break
            } else {
                Swift.print(curNode!.data, terminator: " -> ")
                curNode = curNode?.next
            }
        }
    }
}
