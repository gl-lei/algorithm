//
//  141.swift
//  LeetCode
//
//  Created by ggl on 2020/10/7.
//  Copyright © 2020 ggl. All rights reserved.
//  141环形链表

import Foundation

/*
* 141.环形链表
* 题意：给定一个链表，判断链表中是否有环。如果链表中存在环，则返回true，否则返回false
* 难度：简单
* 分类：链表，哈希表，双指针(快慢指针)
* 算法：使用快慢指针判断两个指针是否相遇，慢指针每次走一步，快指针每次走两步；哈希表遍历链表看结点是否已存在；
*/

/// 解法一：快慢指针。慢指针每次走一步，快指针每次都走两步，如果相遇就说明有环；如果有一个为空，则说明没有环；
/// 时间复杂度：O(N)，空间复杂度O(1)
class Solution141 {
    // 单链表结构
    public class ListNode {
        var val: Int
        var next: ListNode?
        init(_ val: Int) {
            self.val = val
            next = nil
        }
    }
    
    /// 使用快慢指针解决
    func hasCycle(_ head: ListNode?) -> Bool {
        if head == nil || head?.next == nil {
            return false
        }
        var slow = head
        var quick = head?.next
        while quick != nil {
            if slow?.val == quick?.val {
                return true
            }
            
            // 慢指针走一步，快指针走两步
            slow = slow?.next
            quick = quick?.next?.next
        }
        return false
    }
}

/// 解法二：哈希表
/// 时间复杂度：O(N)，空间复杂度：O(N)
class Solution141_1 {
    typealias ListNode = Solution141.ListNode
    
    /// 使用哈希表
    func hasCycle(_ head: ListNode?) -> Bool {
        if head == nil || head?.next == nil {
            return false
        }
        
        var nodeHash = [Int: ListNode]()
        var p = head?.next
        while p != nil {
            if nodeHash[p!.val] != nil {
                return true
            }
            nodeHash[p!.val] = p
            p = p?.next
        }
        return false
    }
}

/// 解法三：逐个删除，会破坏原有的链表结构
/// 时间复杂度：O(N)，空间复杂度：O(1)
class Solution141_2 {
    typealias ListNode = Solution141.ListNode
    
    func hasCycle(_ head: ListNode?) -> Bool {
        if head == nil || head?.next == nil {
            return false
        }
        
        if head?.next?.val == head?.val {
            return true
        }
        
        let nextNode = head?.next
        head?.next = head
        
        // 继续进行判断
        return hasCycle(nextNode)
    }
}
