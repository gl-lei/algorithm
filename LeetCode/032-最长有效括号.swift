//
//  032.swift
//  LeetCode
//
//  Created by ggl on 2020/10/8.
//  Copyright © 2020 ggl. All rights reserved.
//  032最长有效括号

import Foundation

/*
* 032.最长有效括号
* 题意：给定一个只包含 '(' 和 ')' 的字符串，找出最长的包含有效括号的子串的长度。
* 难度：困难
* 分类：动态规划、栈
* 算法：使用动态规划或者使用栈模拟操作
*/

class Solution032 {
    func longestValidParentheses(_ s: String) -> Int {
        // 使用栈模拟，将所有无法匹配的括号位置全部置为1
        // 例如: "()(()"的mark为[0, 0, 1, 0, 0]，或者: ")()((())"的mark为[1, 0, 0, 1, 0, 0, 0, 0]
        // 经过这样的处理，就变成了寻找最长的连续0的长度
        let count = s.count
        var flagArr = [Int](repeating: 0, count: count)
        
        // 记录未匹配的"("的下标位置
        var stack = [Int]()
        for (i, ch) in s.enumerated() {
            if ch == "(" {
                stack.append(i)
            } else {
                // 无法匹配，标记为1
                if stack.isEmpty {
                    flagArr[i] = 1
                } else {
                    stack.removeLast()
                }
            }
        }
        
        // 判断是否为空，标记为1
        while !stack.isEmpty {
            let index = stack.removeLast()
            flagArr[index] = 1
        }
        
        // 查找长度连续为0的最大值
        var ans = 0, len = 0
        for num in flagArr {
            if num == 1 {
                len = 0
                continue
            }
            len += 1
            ans = max(ans, len)
        }
        
        return ans
    }
}
