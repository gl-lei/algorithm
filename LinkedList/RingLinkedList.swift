//
//  RingLinkedList.swift
//  LinkedList
//
//  Created by ggl on 2019/3/28.
//  Copyright © 2019年 ggl. All rights reserved.
//  带环的链表

import Foundation

class RingLinkedList {
    /// 头结点
    var head: Node?
    
    /// 环的位置
    var ringPos: UInt
    
    init(count: UInt, ringPos: UInt) {
        self.ringPos = ringPos
        if count == 0 {
            return
        }
        
        head = Node(data: 1, next: nil)
        var p = head
        var ringNode = head
        var tail = head
        for i in 1..<Int(count) {
            let node = Node(data: i+1, next: nil)
            p?.next = node
            p = node
            
            if i == Int(ringPos) {
                ringNode = node
            } else if i == Int(count) - 1 {
                tail = node
            }
        }
        tail?.next = ringNode
    }
    
    /// 打印带有环的链表
    func print() {
        var p: Node? = head
        var ringNode = head
        var count = 0
        for i in 0..<Int.max {
            if count == 1 && p == ringNode {
                break
            }
            
            if i == self.ringPos {
                ringNode = p
                count = 1
                Swift.print("[\(p!.data)]", terminator: " -> ")
            } else {
                Swift.print(p!.data, terminator: " -> ")
            }
            p = p?.next
        }
        Swift.print("")
    }
}
