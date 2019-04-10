//
//  LinkedListQueue.swift
//  Queue
//
//  Created by ggl on 2019/4/10.
//  Copyright © 2019年 ggl. All rights reserved.
//  链表队列

import Foundation

class LinkedListQueue<Element: Equatable> {
    
    /// 定义链表结点
    class Node: Equatable {
        var data: Element
        var next: Node?
        
        init(data: Element, next: Node?) {
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
    
    var head: Node?
    var tail: Node?
    
    /// 数据加入队列
    ///
    /// - Parameter item: 需要加入队列的数据
    /// - Returns: 是否加入成功
    @discardableResult
    func enQueue(item: Element) -> Bool {
        let node = Node(data: item, next: nil)
        if head == nil {
            head = node
        } else {
            tail?.next = node
        }
        tail = node
        return true
    }
    
    /// 队列中取出数据
    ///
    /// - Returns: 队列中获取到的数据
    func deQueue() -> Element? {
        if head == nil {
            return nil
        }
        
        if tail == head {
            let element = head?.data
            tail = nil
            head = nil
            return element
        }
        
        let item = head?.data
        head = head?.next
        return item
    }
}
