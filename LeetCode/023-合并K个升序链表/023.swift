//
//  023.swift
//  LeetCode
//
//  Created by ggl on 2020/10/7.
//  Copyright © 2020 ggl. All rights reserved.
//  023合并K个升序链表

import Foundation

/*
* 023.合并K个升序链表
* 题意：给你一个链表数组，每个链表都已经按升序排列。请你将所有链表合并到一个升序链表中，返回合并后的链表。
* 难度：困难
* 分类：分治算法，优先级队列(堆)
* 算法：可以借由分治的思想，对数组中的链表进行两两合并排序；优先级队列可以使用小根堆，一个一个的元素出列即可；
*/

/// 采用分治算法求解
/// 时间复杂度：O(N*log(K))，空间复杂度：O(1)，K表示链表的数目，N表示两个链表的总结点数
class Solution023 {
    class ListNode {
        var val: Int
        var next: ListNode?
        
        init() {
            self.val = 0
            self.next = nil
        }
        
        init(_ val: Int) {
            self.val = val
            self.next = nil
        }
        
        init(_ val: Int, _ next: ListNode?) {
            self.val = val
            self.next = next
        }
    }
    
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        if lists.count == 0 {
            return nil
        }
        
        if lists.count == 1 {
            return lists[0]
        }
        
        return recurMergeLists(lists, 0, lists.count-1)
    }
    
    /// 合并low到high之间的有序链表
    /// - Parameters:
    ///   - lists: 链表数组
    ///   - low: 需要合并的数组的小下标
    ///   - high: 需要合并数组的大下标
    /// - Returns: 合并后的链表
    private func recurMergeLists(_ lists: [ListNode?], _ low: Int, _ high: Int) -> ListNode? {
        if low == high {
            return lists[low]
        }
        if low > high {
            return nil
        }
        
        let mid = (low + high) >> 1
        let node1 = recurMergeLists(lists, low, mid)
        let node2 = recurMergeLists(lists, mid+1, high)
        return mergeTwoList(node1, node2)
    }
    
    /// 合并两个链表
    /// - Parameters:
    ///   - oneList: 第一个链表
    ///   - otherList: 第二个链表
    /// - Returns: 合并后的链表
    private func mergeTwoList(_ oneList: ListNode?, _ otherList: ListNode?) -> ListNode? {
        if oneList == nil || otherList == nil {
            return oneList == nil ? otherList : oneList
        }
        var p = oneList
        var q = otherList
        
        // 哨兵结点
        let head = ListNode()
        var tail = head
        while p != nil && q != nil {
            if p!.val < q!.val {
                tail.next = p
                p = p?.next
            } else {
                tail.next = q
                q = q?.next
            }
            tail = tail.next!
        }
        
        while p != nil {
            tail.next = p
            p = p?.next
            tail = tail.next!
        }
        
        while q != nil {
            tail.next = q
            q = q?.next
            tail = tail.next!
        }
        return head.next
    }
}
