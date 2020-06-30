//
//  BMSearch.swift
//  String
//
//  Created by ggl on 2020/6/28.
//  Copyright © 2020 ggl. All rights reserved.
//  BM算法

import Foundation

/// BM算法包括两部分：坏字符规则（bad character rule）和好后缀规则（good suffix shift）
/// 坏字符规则：
/// 1.模式串与主串匹配顺序倒叙，当发现某个字符没法匹配的时候，把没有匹配的字符叫做坏字符（主串中的字符）
/// 2.坏字符规则效率很高，时间复杂度是O(n/m)，例如：aaabaaabaaabaaab 模式串是aaaa，每次匹配都可以直接后移四位（但移动位数可能是负数）
/// 好后缀规则：
/// 1.好后缀在模式串中，是否有另一个匹配的子串（查找跟好后缀匹配的另一个子串）
/// 2.好后缀的后缀子串，是否存在跟模式串的前缀子串匹配的（查找最长的，能跟模式串前缀子串匹配的后缀子串）
/// 好后缀规则可以独立于坏字符规则使用，因为坏字符规则的实现比较耗内存，为了节省内存，我们可以只用好后缀规则来实现BM算法

/// BM算法搜索
/// - Parameters:
///   - subString: 模式串
///   - mainString: 主串
/// - Returns: 匹配的字符串在主串中的起始位置
func bmSearch(subString: String, mainString: String) -> Int? {
    let ssCount = subString.count
    let msCount = mainString.count
    if ssCount > msCount || ssCount == 0 || msCount == 0 {
        return nil
    }
    
    // 生成模式串字符对应下标信息
    let bcHash = generateBC(pattern: subString)
    let (suffix, prefix) = generateGS(pattern: subString)
    
    // i的取值范围mainString[0...msCount-ssCount]
    var i = 0
    while i <= msCount - ssCount  {
        // 坏字符以及坏字符在模式串中所对应的下标
        var bcIndex = -1
        var bcChar = Character(" ")
        
        // 模式串从后往前遍历
        for j in (0..<ssCount).reversed() {
            // 主串中字符位置，相当于mainString[i+j]
            let mIndex = mainString.index(mainString.startIndex, offsetBy: i+j)
            // 模式串中字符位置，相当于subString[j]
            let sIndex = subString.index(subString.startIndex, offsetBy: j)
            
            // 找到坏字符位置
            if mainString[mIndex] != subString[sIndex] {
                bcIndex = j
                bcChar = mainString[mIndex]
                break
            }
        }
        if bcIndex < 0 {
            // 匹配成功，返回主串与模式串第一个匹配的字符位置
            return i
        }
        
        // 搜索坏字符在模式串匹配的位置，计算滑动的位数
        var x = 0
        if let matchBCIndex = bcHash[bcChar] {
            x = bcIndex - matchBCIndex
        } else {
            x = bcIndex + 1
        }
        
        // 计算好后缀规则滑动的位数
        var y = 0
        if bcIndex < ssCount - 1 {
            // 如果有好后缀的话
            y = moveByGS(bcIndex: bcIndex, patternCount: ssCount, suffix: suffix, prefix: prefix)
        }
        
        // 两个规则取滑动位数最大的，避免坏字符规则，计算得到的往后滑动的位数，有可能是负数的情况
        i = i + max(x, y)
    }
    return -1
}

/// 生成模式串中的所有字符作为Key，对应下标作为value的哈希表，用来求坏字符在模式串中的位置
/// 这里先不考虑优化，直接使用散列表
/// - Parameter pattern: 模式串
/// - Returns: 模式串每个字符对应下标散列表
private func generateBC(pattern: String) -> [Character: Int] {
    var hash = [Character: Int]()
    for (i, char) in pattern.enumerated() {
        hash[char] = i
    }
    return hash
}

/// 生成模式串的suffix数组和prefix数组
/// - Parameter pattern: 模式串
/// - Returns: suffix数组，表示好后缀在模式串的相同串对应的位置；prefix数组，表示好后缀后缀子串与模式串的前缀子串匹配信息
private func generateGS(pattern: String) -> (suffix: [Int], prefix: [Bool]) {
    // 初始化
    let count = pattern.count
    var suffix = [Int](repeating: -1, count: count)
    var prefix = [Bool](repeating: false, count: count)
    
    for i in 0..<count-1 {
        // 从后往前遍历
        var j = i
        // 公共后缀子串长度
        var k = 0
        
        // pattern[0...i] 与 pattern[0...count-1] 求公共后缀子串
        while j >= 0 {
            // 模式串前缀子串 pattern[0...i]
            let prefixIndex = pattern.index(pattern.startIndex, offsetBy: j)
            // 模式串后缀子串，pattern[0...count-1] 从后往前开始匹配，注意endIndex的含义
            let suffixIndex = pattern.index(pattern.endIndex, offsetBy: -(k+1))
            
            if pattern[prefixIndex] != pattern[suffixIndex] {
                break
            }
            j -= 1
            k += 1
            
            // j+1表示公共后缀子串在pattern[0...i]中的起始下标
            suffix[k] = j+1
        }
        
        // 如果公共后缀子串也是模式串的前缀子串
        if j == -1 {
            prefix[k] = true
        }
    }
    return (suffix, prefix)
}

/// 计算好后缀规则需要滑动的位数
/// - Parameters:
///   - bcIndex: 坏字符所在模式串中的下标，用来计算好后缀的长度
///   - patternCount: 模式串的长度
///   - suffix: 好后缀在模式串匹配的子串的信息
///   - prefix: 好后缀的后缀子串在模式串匹配的前缀子串的信息
/// - Returns: 滑动的位数
private func moveByGS(bcIndex: Int, patternCount: Int, suffix: [Int], prefix: [Bool]) -> Int {
    // 好后缀的长度
    let k = patternCount - 1 - bcIndex
    if suffix[k] != -1 {
        // 表示有搜索到的匹配子串
        return bcIndex - suffix[k] + 1
    }
    
    // 好后缀的后缀子串pattern[r, patternCount-1]，其中r的取值范围为：bcIndex+2到m-1
    for r in bcIndex+2..<patternCount {
        // 好后缀后缀子串的长度
        let suffixCount = patternCount - r
        if prefix[suffixCount] {
            // 表示长度为suffixCount的子串，有匹配的前缀子串
            return r
        }
    }
    return patternCount
}

