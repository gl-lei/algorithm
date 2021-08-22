//
//  002.swift
//  LeetCode
//
//  Created by ggl on 2020/6/14.
//  Copyright © 2020 ggl. All rights reserved.
//  002两数相加

import Foundation

/*
 * 2. 两数相加
 * 题意：用逆序链表存储整数，返回两个整数相加的结果链表
 * 难度：中等
 * 分类：链表
 * 算法：链表操作，考虑两个数字相加溢出（进位）的情况
 */

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */
class Solution002 {
    // 结点结构
    class ListNode {
        var val: Int
        var next: ListNode?
        init(_ val: Int) {
            self.val = val
            self.next = nil
        }
    }
    
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1, l2 = l2
        // 哨兵结点
        let headNode: ListNode? = ListNode(0)
        var p = headNode
        
        // 是否进位标识
        var flag = 0
        while l1 != nil || l2 != nil {
            var sum = flag
            if let v1 = l1?.val {
                sum += v1
                l1 = l1?.next
            }
            if let v2 = l2?.val {
                sum += v2
                l2 = l2?.next
            }
            
            // 求结果与进位
            let result = sum % 10
            flag = sum / 10
            
            // 准备下一次循环
            p?.next = ListNode(result)
            p = p?.next
        }
        
        // 不要忘记最后进位的情况判断
        if flag > 0 {
            p?.next = ListNode(flag)
        }
        return headNode?.next
    }
    
    func print(node: ListNode?) {
        if node == nil {
            return
        }
        
        var p = node
        Swift.print("\(p!.val)", terminator: "")
        while p?.next != nil {
            Swift.print(" -> \(p!.next!.val)", terminator: "")
            p = p?.next
        }
        Swift.print("")
    }
}

// 扩展：如果链表中的数字不是按逆序存储的呢？
