//
//  LoopQueue.swift
//  Queue
//
//  Created by ggl on 2019/4/10.
//  Copyright © 2019年 ggl. All rights reserved.
//  循环队列

import Foundation

class LoopQueue<Element> {
    
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
        // 队列满的判断条件为：(tail + 1) % n = head
        if (tail + 1) % array.count == head {
            //表示队列满了
            print("队列满了")
            return false
        }
        
        array[tail] = item
        tail = (tail + 1) % array.count
        return true
    }
    
    /// 队列中取出数据
    ///
    /// - Returns: 队列中获取到的数据
    func deQueue() -> Element? {
        if tail == head {
            print("队列空了")
            return nil
        }
        
        let item = array[head]
        array[head] = nil
        head = (head + 1) % array.count
        return item
    }
}
