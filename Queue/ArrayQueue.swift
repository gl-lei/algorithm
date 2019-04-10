//
//  ArrayQueue.swift
//  Queue
//
//  Created by ggl on 2019/4/10.
//  Copyright © 2019年 ggl. All rights reserved.
//  顺序队列

import Foundation

class ArrayQueue<Element> {
    
    /// 队列底层存储数组，这里做了优化，让其大小固定
    var array: [Element?]
    
    /// 队列首指针
    var head: Int
    
    /// 队列尾指针
    var tail: Int
    
    init(capcity: Int) {
        array = [Element?](repeating: nil, count: capcity);
        head = 0
        tail = 0
    }
    
    /// 数据加入队列
    ///
    /// - Parameter item: 需要加入队列的数据
    /// - Returns: 是否加入成功
    @discardableResult
    func enQueue(item: Element) -> Bool {
        if tail == array.count {
            if head == 0 {
                //表示队列满了，无法再插入新的元素
                return false
            }
            //数据搬移
            for index in head..<tail {
                array[index - head] = array[index]
            }
            tail -= head
            head = 0
        }
        array[tail] = item
        tail += 1
        return true
    }
    
    /// 队列中取出数据
    ///
    /// - Returns: 队列中获取到的数据
    func deQueue() -> Element? {
        if tail == head {
            return nil
        }
        
        let item = array[head]
        array[head] = nil
        head += 1
        return item
    }
}
