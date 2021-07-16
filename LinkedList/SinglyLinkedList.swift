//
//  SinglyLinkedList.swift
//  LinkedList
//
//  Created by ggl on 2019/3/28.
//  Copyright © 2019年 ggl. All rights reserved.
//  单链表

import Foundation

class Node: Equatable {
    var data: Int = 0
    var next: Node?
    
    init(data: Int, next: Node?) {
        self.data = data
        self.next = next
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        if lhs.data == rhs.data {
            return true
        }
        return false
    }
}

class SinglyLinkedList {
    var head: Node?
    
    /// 添加结点
    ///
    /// - Parameter node: 新节点
    func addNode(_ data: Int) {
        let node = Node(data: data, next: nil)
        guard let tailNode = tailNode() else {
            head = node
            return
        }
        tailNode.next = node
    }
    
    @discardableResult
    func deleteNode(_ data: Int) -> Bool {
        // 链表是单向的，所以需要始终有一个前向指针
        var curNode = head
        var preNode = head
        // 链表是否为空
        if curNode == nil {
            return false
        }
        
        // 链表头结点是否等于指定的结点
        if curNode!.data == data {
            head = curNode?.next
            return true
        }
        
        while curNode!.next != nil {
            preNode = curNode
            curNode = curNode?.next
            
            // 比对结点的数据是否相同
            if curNode!.data == data {
                preNode?.next = curNode?.next
                return true
            }
        }
        return false
    }
    
    /// 获取链表的最后一个结点
    ///
    /// - Returns: 尾结点
    func tailNode() -> Node? {
        guard var tailNode = head else {
            return nil
        }
        
        while tailNode.next != nil {
            tailNode = tailNode.next!
        }
        return tailNode
    }
    
    /// 链表反转
    func reverse() {
        if head == nil || head?.next == nil {
            return
        }
        
        // pre指针指向前一个结点、cur指针指向当前需要反转的结点
        var pre = head
        var cur = head?.next
        head?.next = nil
        while cur != nil {
            let next = cur?.next
            cur?.next = pre
            
            // 进行下次循环
            pre = cur
            cur = next
        }
        head = pre
    }
    
    /// 递归反转
    @discardableResult
    func reverse(_ node: Node?) -> Node? {
        if node == nil || node?.next == nil {
            return node
        }
        // 注意，始终返回尾结点
        let newHead = reverse(node?.next)
        // 防止形成环，例如1 -> 2 -> 3 <- 4 <- 5，当前 node 为 2，需要反转链表
        node?.next?.next = node
        node?.next = nil
        return newHead
    }
    
    /// 求链表的中间结点(快慢指针)
    ///
    /// - Returns: 链表的中间结点
    func middleNode() -> Node? {
        if head == nil || head?.next == nil {
            return nil
        }
        
        var slow = head
        var fast = head
        while fast?.next != nil && fast?.next?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        return slow
    }
    
    /// 求链表倒数第K个结点（K大于等于1）（使用快慢指针）
    ///
    /// - Parameter lastK: 倒数第几个位置
    /// - Returns: 倒数第K个结点
    func lastKNode(lastK: Int) -> Node? {
        if head == nil || lastK < 1 {
            return nil
        }
        
        // 使用快、慢指针来解决
        var slow = head
        var fast = head
        // 快指针先走K步
        for _ in 0..<lastK-1 {
            fast = fast?.next
        }
        
        // 如果快指针走出去了，则表示K值过大，返回nil
        if fast == nil {
            return nil
        }
        
        // 快慢指针一起走，快指针走到头后慢指针位置则为倒数第K个结点
        while fast?.next != nil {
            slow = slow?.next
            fast = fast?.next
        }
        return slow
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
