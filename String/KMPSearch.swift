//
//  KMPSearch.swift
//  String
//
//  Created by ggl on 2020/7/3.
//  Copyright © 2020 ggl. All rights reserved.
//  KMP算法

import Foundation

/// KMP算法链接 https://www.cnblogs.com/zhangtianq/p/5839909.html
/// BM是去滑动主串，KMP是利用模式串的好前缀规则去跳过模式串（相当于滑动模式串）主串递增的形式
/// next数组的意义：首先next数组与模式串的大小一致，下标代表当前模式串的前缀子串，值代表当前字符之前的字符串中，有多大长度的相同前缀后缀（长度）
/// 如果next[j] = k，代表j之前的字符串中有最大长度为k的相同前缀后缀，k代表最大前缀子串长度
/// 算法复杂度：O(M+N)
/// KMP比较时，是对模式串从前往后进行比较，对于主串已经比较过的部分，保持主串i指针(即下标)不回溯，
/// 而是通过修改模式串的“j”指针，变相的让模式串移动到有效的位置
/// - Parameters:
///   - subString: 模式串
///   - mainString: 主串
/// - Returns: 匹配的字符串在主串中的起始位置
func kmpSearch(subString: String, mainString: String) -> Int? {
    let ssCount = subString.count
    let msCount = mainString.count
    if ssCount > msCount || ssCount == 0 || msCount == 0 {
        return nil
    }
    
    // next数组
    let next = getKMPNext(pattern: subString)
    
    /// i指向主串，j指向模式串
    var i = 0, j = 0
    while i < msCount && j < ssCount {
        // 如果j == -1 或者当前字符匹配成功，
        if j == -1 || mainString[i] == subString[j] {
            i += 1
            j += 1
        } else {
            // 失配时，模式串向右移动的位数 = 失配字符所在位置 - 失配字符对应的next值
            // 如果 j != -1 且当前字符匹配成功，则i不变，j = next[j]
            j = next[j]
        }
    }
    
    if j == ssCount {
        return i - j
    } else {
        return nil
    }
}

/// 返回Next数组
/// - Parameter pattern: 模式串
/// - Returns: Next数组
private func getKMPNext(pattern: String) -> [Int] {
    let count = pattern.count
    var next = [Int](repeating: -1, count: count)
    
    // k表示最大前缀子串的长度，j表示当前匹配的字符位置
    var k = -1
    var j = 0
    while j < count - 1 {
        // 因为最大前缀子串与最大后缀子串是相对应的，pattern[j] 和 pattern[k] 相等的话，即表示next[j] = k
        if k == -1 || pattern[j] == pattern[k] {
            k += 1
            j += 1
            
            // https://www.cnblogs.com/zhangtianq/p/5839909.html
            // 未优化之前的数组求和
            next[j] = k
            
            /*
            // 优化之后的数组求和
            if pattern[j] != pattern[k] {
                next[j] = k;
            } else {
                // 因为不能同时出现p[j] = p[next[j]]，所以当出现时需要继续递归 k = next[k] = next[next[k]]
                next[j] = next[k]
            }*/
        } else {
            // 因为pattern[j]和pattern[k]不想等，则需要在pattern[k] 的最大前缀子串中再进行查找（也就是找次最大后缀子串）
            k = next[k]
        }
    }
    
    return next
}
