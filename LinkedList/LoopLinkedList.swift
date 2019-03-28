//
//  LoopLinkedList.swift
//  LinkedList
//
//  Created by ggl on 2019/3/28.
//  Copyright © 2019年 ggl. All rights reserved.
//  循环链表

import Foundation

class LoopLinkedList {
    var head: Node?
    
    /// 添加结点
    ///
    /// - Parameter node: 新节点
    func addNode(_ data: Int) {
        let node = Node(data: data, next: nil)
        guard let tailNode = self.tailNode() else {
            head = node
            node.next = head
            return
        }
        tailNode.next = node
        node.next = head
    }
    
    @discardableResult
    func deleteNode(_ data: Int) -> Bool {
        // 空链表
        if head == nil {
            return false
        }
        
        // 头结点是否是要删除的结点
        if head?.data == data {
            head = head?.next
            let tailNode = self.tailNode()
            tailNode?.next = head
            return true
        }
        
        // 前后指针
        var preNode = head
        var curNode = head?.next
        while curNode != head {
            if curNode?.data == data {
                preNode?.next = curNode?.next
                return true
            }
            preNode = curNode
            curNode = curNode?.next
        }
        return false
    }
    
    /// 获取链表的最后一个结点
    ///
    /// - Returns: 尾结点
    func tailNode() -> Node? {
        // 判断是否是空链表
        if head == nil {
            return nil
        }
        
        // 尾结点
        var tailNode = head
        while tailNode?.next != head {
            tailNode = tailNode?.next
        }
        return tailNode
    }
    
    /// 打印链表
    func print() {
        var curNode = head
        while curNode != nil {
            if curNode?.next == head {
                Swift.print(curNode!.data)
                break
            } else {
                Swift.print(curNode!.data, terminator: " -> ")
                curNode = curNode?.next
            }
        }
    }
}
