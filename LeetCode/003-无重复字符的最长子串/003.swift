//
//  003.swift
//  LeetCode
//
//  Created by ggl on 2020/7/5.
//  Copyright © 2020 ggl. All rights reserved.
//  003无重复字符的最长子串

import Foundation

/*
 * 3. 无重复字符的最长子串
 * 题意：给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。
 * 难度：中等
 * 分类：字符串，哈希表
 * 算法：滑动窗口，两个指针代表某个子串的左右边界，左指针移动时哈希集合移除一个字符，右指针移动时，往哈希集合中添加一个字符
 */

// 第一种方法：使用哈希表记录每个字符的位置，快速滑动
// 由于使用的哈希表，查找较快，执行速度较快
class Solution003 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        // 存储当前的字符以及字符距离起始位置的长度
        var subMap = [Character: Int]()
        // 左指针
        var i = 0
        // 最大长度
        var ans = 0

        // 开始移动左指针
        // 字符串下标操作需要使用index，效率及其低下，在leetcode中提交总是报超时错误
        // 在涉及字符串遍历的时候，最好使用 `for ch in string` 这种，而不是 `for i in string.count`
        for (j, ch) in s.enumerated() {
            // 遇到重复字符，需要调整左指针的位置
            if subMap[ch] != nil {
                // 这里需要取max，为什么呢？例如：abba
                i = max(subMap[ch]!, i)
            }
            subMap[ch] = j + 1
            ans = max(ans, j - i + 1)
        }
        return ans
    }
}

// 第二种方法：遇到重复的字符，从头开始删除，直到不包含重复的字符
// 由于没有使用哈希查找，查找字符会比较慢，执行较慢
class Solution003_1 {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        // 最长串
        var maxStr = ""
        // 当前串
        var curStr = ""
        
        // 利用滑动窗口原理
        for ch in s {
            if let index = curStr.firstIndex(of: ch) {
                curStr.removeSubrange(...index)
            }
            
            curStr.append(ch)
            // 比较记录最长串
            if curStr.count > maxStr.count {
                maxStr = curStr
            }
        }
        return maxStr.count
    }
}
