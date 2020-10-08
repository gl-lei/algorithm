//
//  main.swift
//  Queue
//
//  Created by ggl on 2019/4/10.
//  Copyright © 2019年 ggl. All rights reserved.
//

import Foundation

//MARK: - 顺序队列
print("===============顺序队列=================")
var arrayQueue = ArrayQueue<String>(capcity: 5)
arrayQueue.enQueue(item: "北京欢迎您")
arrayQueue.enQueue(item: "加油、加油")
arrayQueue.enQueue(item: "奋斗")

for _ in 0..<8 {
    if let item = arrayQueue.deQueue() {
        print("队列中取出的内容：\(item)")
    }
}
arrayQueue.enQueue(item: "星期二")

//MARK: - 链式队列
print("===============链式队列=================")
var linkedListQueue = LinkedListQueue<String>()
linkedListQueue.enQueue(item: "北京欢迎您")
linkedListQueue.enQueue(item: "加油、加油")
linkedListQueue.enQueue(item: "奋斗")

for _ in 0..<8 {
    if let item = linkedListQueue.deQueue() {
        print("队列中取出的内容：\(item)")
    }
}
linkedListQueue.enQueue(item: "星期二")

//MARK: - 循环队列
print("===============循环队列=================")
var loopQueue = LoopQueue<Int>(capcity: 5)
for i in 1...10 {
    loopQueue.enQueue(item: i)
}

if let item = loopQueue.deQueue() {
    print("获取的元素：\(item)")
}



