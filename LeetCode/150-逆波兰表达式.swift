//
//  150-逆波兰表达式.swift
//  LeetCode
//
//  Created by ggl on 2022/8/11.
//  Copyright © 2022 ggl. All rights reserved.
//

import Foundation

/*
* 150. 逆波兰表达式求值
* 题意：
    根据 逆波兰表示法，求表达式的值。
    有效的算符包括 +、-、*、/ 。每个运算对象可以是整数，也可以是另一个逆波兰表达式。
    注意 两个整数之间的除法只保留整数部分。
    可以保证给定的逆波兰表达式总是有效的。换句话说，表达式总会得出有效数值且不存在除数为 0 的情况。

    来源：力扣（LeetCode）
    链接：https://leetcode.cn/problems/evaluate-reverse-polish-notation
    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
* 难度：中等
* 分类：栈
* 算法：遇到数字进栈，遇到符号将操作数出栈，并进行运算。
*/

class Solution150 {
    func evalRPN(_ tokens: [String]) -> Int {
        // 存储数结果
        var stack = [Int]()
        for str in tokens {
            if let num = Int(str) {
                stack.append(num)
            } else {
                // 取出操作数
                let num2 = stack.removeLast()
                let num1 = stack.removeLast()
                
                var result = 1
                switch str {
                case "+":
                    result = num1 + num2
                case "-":
                    result = num1 - num2
                case "*":
                    result = num1 * num2
                case "/":
                    result = num1 / num2
                default:
                    result = num1 + num2
                }
                
                stack.append(result)
            }
        }
        return stack.first!
    }
}
