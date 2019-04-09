//
//  LinkedListStack.swift
//  Stack
//
//  Created by ggl on 2019/4/8.
//  Copyright © 2019年 ggl. All rights reserved.
//  链式栈

import Foundation

class LinkedListStack<Element> {
    
    /// 定义链表结点
    class Node {
        var data: Element
        var next: Node?
        
        init(data: Element, next: Node?) {
            self.data = data
            self.next = next
        }
    }
    
    /// 底层链表
    var head: Node?
    
    /// 元素的个数
    var count: Int
    
    init() {
        count = 0
    }
    
    /// 元素入栈
    ///
    /// - Parameter item: 需要入栈的元素
    func push(_ item: Element) {
        let node = Node(data: item, next: nil)
        if head == nil {
            head = node
            count = 1
            return
        }
        
        node.next = head
        head = node
        count += 1
    }
    
    /// 元素出栈
    ///
    /// - Returns: 需要出栈e的元素
    @discardableResult
    func pop() -> Element? {
        if count == 0 {
            return nil
        }
        count -= 1
        
        let item = head!
        head = head?.next
        return item.data
    }
    
    /// 打印元素
    func print() {
        Swift.print("LinkedListStack元素（靠前的元素表示栈顶元素）：", terminator: "")
        var item = head
        for _ in 0..<count {
            Swift.print(item!.data, terminator: " ")
            item = item?.next
        }
        Swift.print("")
    }
}
