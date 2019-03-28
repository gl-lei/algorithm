//
//  LinkedListFunc.swift
//  LinkedList
//
//  Created by ggl on 2019/3/28.
//  Copyright © 2019年 ggl. All rights reserved.
//  链表功能函数

import Foundation

/// 合并两个有序单链表
///
/// - Parameters:
///   - linkedListOne: 第一个有序单链表
///   - linkedListTwo: 第二个有序单链表
/// - Returns: 合并有序的单链表
func mergeLinkedList(linkedListOne: SinglyLinkedList, linkedListTwo: SinglyLinkedList) -> SinglyLinkedList {
    let mergeLinkedList = SinglyLinkedList()
    var p = linkedListOne.head, q = linkedListTwo.head
    if p == nil || q == nil {
        return mergeLinkedList
    }
    
    while p != nil || q != nil {
        if p == nil {
            mergeLinkedList.addNode(q!.data)
            q = q?.next
        } else if q == nil {
            mergeLinkedList.addNode(p!.data)
            p = p?.next
        } else {
            if p!.data > q!.data {
                mergeLinkedList.addNode(q!.data)
                q = q?.next
            } else {
                mergeLinkedList.addNode(p!.data)
                p = p?.next
            }
        }
    }
    return mergeLinkedList
}
