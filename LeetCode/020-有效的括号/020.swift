//
//  020.swift
//  LeetCode
//
//  Created by ggl on 2020/10/8.
//  Copyright © 2020 ggl. All rights reserved.
//  020有效的括号

import Foundation

/*
* 20. 有效的括号
* 题意：给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。
       有效字符串需满足：
            - 左括号必须用相同类型的右括号闭合。
            - 左括号必须以正确的顺序闭合。
* 注意：空字符串可被认为是有效字符串。
* 难度：简单
* 分类：栈
* 算法：使用栈结构来存储字符数据，当遇到闭合的字符时，需要对栈元素进行出栈操作，并且判断出栈的元素是否是匹配的左括号；
*/

class Solution020 {
    func isValid(_ s: String) -> Bool {
        if s.isEmpty {
            return true
        }
        let pairChsMap: [Character: Character] = [")": "(", "}": "{", "]": "["]
        
        // 栈结构
        var stack = [Character]()
        for c in s {
            if pairChsMap.keys.contains(c) {
                guard let popCh = stack.popLast() else {
                    return false
                }
                if popCh != pairChsMap[c]! {
                    return false
                }
            } else {
                stack.append(c)
            }
        }
        
        // 判断数组是否全部匹配完毕
        return stack.isEmpty
    }
}
