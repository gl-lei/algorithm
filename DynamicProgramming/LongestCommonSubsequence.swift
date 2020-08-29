//
//  LongestCommonSubsequence.swift
//  DynamicProgramming
//
//  Created by ggl on 2020/8/25.
//  Copyright © 2020 ggl. All rights reserved.
//  最长公共子序列

import Foundation

/**
 * 如果a[i]和b[j]互相匹配，我们将最大公共子串长度加一，并继续考察a[i+1]和b[j+1]
 * 如果a[i]和b[j]不匹配，最长公共子串长度不变，这个时候有两个不同的决策路线：
 * 删除a[i]，或者在b[j]前面加上一个字符a[i]，然后继续考察a[i+1]和b[j]
 * 删除b[j]，或者在a[i]前面加上一个字符b[j]，然后继续考察a[i]和b[j+1]
 */

/// 动态规划求两字符串的最长公共子序列
/// 状态转移方程
/// 如果aString[i] == bString[j], 那么states[i][j] = max(states[i-1][j], states[i][j-1], states[i-1][j-1]+1);
/// 如果aString[i] != bString[j], 那么steates[i][j] = max(states[i-1][j], states[i][j-1], states[i-1][j-1]);
///
/// - Parameters:
///   - aString: 第一个字符串
///   - bString: 第二个字符串
/// - Returns: 最长公共子序列长度
func lcsDistanceDP(aString: String, bString: String) -> Int {
    var states = [[Int]](repeating: [Int](repeating: 0, count: bString.count), count: aString.count)
    // 初始化第一行 aString[0...0]与bString[0...j]的最长公共子序列
    for j in 0..<bString.count {
        let iIndex = aString.startIndex
        let jIndex = bString.index(bString.startIndex, offsetBy: j)
        
        if aString[iIndex] == bString[jIndex] {
            states[0][j] = 1
        } else if j == 0 {
            states[0][0] = 0
        } else {
            states[0][j] = states[0][j-1]
        }
    }
    
    // 初始化第一列 aString[0...i]和bString[0...0]的最长公共子序列
    for i in 0..<aString.count {
        let iIndex = aString.index(aString.startIndex, offsetBy: i)
        let jIndex = bString.startIndex
        
        if aString[iIndex] == bString[jIndex] {
            states[i][0] = 1
        } else if i == 0 {
            states[0][0] = 0
        } else {
            states[i][0] = states[i-1][0]
        }
    }
    
    // 其他行填充
    for i in 1..<aString.count {
        for j in 1..<bString.count {
            let iIndex = aString.index(aString.startIndex, offsetBy: i)
            let jIndex = bString.index(bString.startIndex, offsetBy: j)
            
            if aString[iIndex] == bString[jIndex] {
                states[i][j] = Swift.max(states[i][j-1], states[i-1][j], states[i-1][j-1]+1)
            } else {
                states[i][j] = Swift.max(states[i][j-1], states[i-1][j], states[i-1][j-1])
            }
        }
    }
    
    // 动态规划，最长公共子序列数组
    print("最长公共子串长度状态数组=>")
    for i in 0..<aString.count {
        for j in 0..<bString.count {
            print("\(states[i][j]) ", terminator: "")
        }
        print("")
    }
    
    // 返回结果
    return states[aString.count-1][bString.count-1]
}

// 最长公共子序列长度
private var maxLcsDist = Int.min

/// 回溯算法计算两个字符串的最长公共子序列
///
/// - Parameters:
///   - aString: 第一个字符串
///   - bString: 第二个字符串
/// - Returns: 最长公共子序列的长度
func lcsDistance(aString: String, bString: String) -> Int {
    recurLcsDistance(iString: aString, jString: bString, i: 0, j: 0, lcs: 0)
    return maxLcsDist;
}

/// 回溯算法计算两个字符串的最长公共子序列
///
/// - Parameters:
///   - iString: 第一个字符串
///   - jString: 第二个字符串
///   - i: 第一个字符串的当前下标
///   - j: 第二个字符串的当前下标
///   - lcs: 当前公共子序列的长度
func recurLcsDistance(iString: String, jString: String, i: Int, j: Int, lcs: Int) {
    if i == iString.count || j == jString.count {
        if maxLcsDist < lcs {
            maxLcsDist = lcs
        }
        return
    }
    
    let iIndex = iString.index(iString.startIndex, offsetBy: i)
    let jIndex = jString.index(jString.startIndex, offsetBy: j)
    
    // 检测当前字符是否一致
    if iString[iIndex] == jString[jIndex] {
        recurLcsDistance(iString: iString, jString: jString, i: i+1, j: j+1, lcs: lcs+1)
    } else {
        recurLcsDistance(iString: iString, jString: jString, i: i+1, j: j, lcs: lcs)
        recurLcsDistance(iString: iString, jString: jString, i: i, j: j+1, lcs: lcs)
    }
}
