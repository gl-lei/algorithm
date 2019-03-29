//
//  main.swift
//  LinkedList
//
//  Created by ggl on 2019/3/28.
//  Copyright © 2019年 ggl. All rights reserved.
//  链表的操作函数

import Foundation

//MARK: - 单链表
let singlyLinkedList = SinglyLinkedList()
singlyLinkedList.print()
for i in 1...10 {
    singlyLinkedList.addNode(i)
}
singlyLinkedList.print()

singlyLinkedList.deleteNode(7)
singlyLinkedList.deleteNode(1)
singlyLinkedList.deleteNode(2)
singlyLinkedList.deleteNode(10)
singlyLinkedList.print()
singlyLinkedList.addNode(12)
singlyLinkedList.print()
print("=================================================\n")

//MARK: - 循环链表
let loopLinkedList = LoopLinkedList()
loopLinkedList.print()

for i in 1...10 {
    loopLinkedList.addNode(i)
}
loopLinkedList.print()
loopLinkedList.deleteNode(2)
loopLinkedList.deleteNode(10)
loopLinkedList.print()
let tailNode = loopLinkedList.tailNode()!
print("头结点值: \(loopLinkedList.head!.data), 尾结点的下一个结点值: \(tailNode.next!.data)")
print("=================================================\n")

//MARK: - 双向链表
let doublyLinkedList = DoublyLinkedList()
doublyLinkedList.print()

for i in 1...10 {
    doublyLinkedList.addNode(i)
}
doublyLinkedList.print()
doublyLinkedList.deleteNode(1)
doublyLinkedList.print()
doublyLinkedList.deleteNode(10)
doublyLinkedList.deleteNode(7)
doublyLinkedList.print()
print("=================================================\n")

//MARK: - 链表函数
print("单链表反转")
singlyLinkedList.reverse()
singlyLinkedList.print()

print("\n合并两个有序单链表为一个有序单链表")
let linkedListOne = SinglyLinkedList()
linkedListOne.addNode(1)
linkedListOne.addNode(5)
linkedListOne.addNode(8)
linkedListOne.addNode(9)
linkedListOne.print()

let linkedListTwo = SinglyLinkedList()
linkedListTwo.addNode(1)
linkedListTwo.addNode(2)
linkedListTwo.addNode(4)
linkedListTwo.addNode(7)
linkedListTwo.addNode(14)
linkedListTwo.print()

let mergeList = mergeLinkedList(linkedListOne: linkedListOne, linkedListTwo: linkedListTwo)
mergeList.print()

print("=================================================")
print("求链表的中间结点")
let linkedList = SinglyLinkedList()
for i in 1...7 {
    linkedList.addNode(i)
}
linkedList.print()
if let middleNode = linkedList.middleNode() {
    print(middleNode.data)
}

print("=================================================")
linkedList.print()
let lastK = 2
print("求链表的倒数第\(lastK)个结点")
if let lastKNode = linkedList.lastKNode(lastK: lastK) {
    print(lastKNode.data)
}

print("=================================================")
print("判断链表是否有环，以及链表环的位置")
let ringLinkedList = RingLinkedList(count: 10, ringPos: 4)
ringLinkedList.print()

let hasRing = checkLinkedListRingNode(ringLinkedList.head)
print("是否有环：\(hasRing ? "是" : "否")")
let ringPos = findLinkedListRingNodePos(ringLinkedList.head)
print("环的入口位置数据为：\(ringPos)")

