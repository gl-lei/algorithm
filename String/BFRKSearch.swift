//
//  String.swift
//  String
//
//  Created by ggl on 2020/6/25.
//  Copyright © 2020 ggl. All rights reserved.
//  字符串匹配

import Foundation

/// BF 算法是 Brute Force 的缩写，中文叫做暴力匹配算法，也叫做朴素匹配算法
/// BF 算法时间复杂度为O(n*m)，n表示主串的长度，m表示子串的长度
/// RK算法在BF算法的基础上进行了改造升级，引入哈希算法，降低了时间复杂度O(n)

/// 使用BF算法在主串中搜索模式串
/// - Parameters:
///   - subString: 模式串，长度小于主串
///   - mainString: 主串
/// - Returns: 查找到的模式串起始索引
func bfSearch(subString: String, mainString: String) -> Int? {
    // 获取主串和模式串的长度
    let subLength = subString.count
    let mainLength = mainString.count
    guard subLength > 0, mainLength > 0, subLength < mainLength else {
        return nil
    }
    
    // 在Swift中，由于不同的字符占用不同的存储空间，为了确定字符的位置，必须要遍历整个字符串
    // 所以，Swift中的String类型不能直接通过整型的下标来进行表示
    // i指向主串指针，j指向模式串指针
    var i = 0, j = 0
    while i < mainLength && j < subLength {
        if mainString[i] == subString[j] {
            // 如果匹配成功，i++,j++
            i += 1
            j += 1
        } else {
            // i回溯并往前移动一位,j=0
            i = i - j + 1
            j = 0
        }
    }
    
    // 判断是否匹配成功
    if j == subLength {
        // 匹配成功
        return i - j
    } else {
        // 未匹配成功
        return nil
    }
}

/// 使用RK算法在主串中搜索模式串，我们假设字符串只包含a~z这26个小写字母，模式串的长度不超过12
/// RK算法主要巧妙的设计在于哈希算法的设计，假设字符串只包含a~z这26个小写字母，则可以用二十六进制来表示一个字符串，相邻串的哈希值存在
/// 一定的规律，可以借助此规律来提高计算哈希值的效率
/// RK算法的整体时间复杂度为O(n)
/// - Parameters:
///   - subString: 模式串，长度小于主串
///   - mainString: 主串
/// - Returns: 查找到的模式串起始索引
func rkSearch(subString: String, mainString: String) -> Int? {
    // 获取主串和模式串的长度
    let subLength = subString.count
    let mainLength = mainString.count
    guard subLength > 0, mainLength > 0, subLength < mainLength else {
        return nil
    }
    
    // 首先对比第一个子串
    let subStrRKHash = subString.rkHashValue
    print("subStrRKHash: \(subStrRKHash)")
    let range = mainString.startIndex...mainString.index(mainString.startIndex, offsetBy: subLength-1)
    var preStrRKHash = mainString[range].rkHashValue
    print("subStr: \"\(mainString[range])\" hash: \(preStrRKHash), rkHash: \(mainString[range].rkHashValue)")
    if preStrRKHash == subStrRKHash {
        return 0
    }
    
    // 快速计算剩下的子串的哈希值
    for i in 1..<(mainLength-subLength+1) {
        // 子串起始下标
        let curIndex = mainString.index(mainString.startIndex, offsetBy: i)
        let endIndex = mainString.index(curIndex, offsetBy: subLength-1)
        
        // 字符a的ascii值
        let aAsciiValue = Character("a").asciiValue!
        
        // 使用快捷计算公式：h[i] = (h[i-1] - 26^(m-1) * (S[i-1] - 'a')) * 26 + (s[i+m-1] - 'a')
        // 其中h[i]对应子串S[i-1...i+m-2]的哈希值，h[i]代表对应子串S[i...i+m-1]的哈希值，m代表子串的长度
        let preChHashValue = Int(mainString[mainString.index(before: curIndex)].asciiValue! - aAsciiValue + 1)
        let endChHashValue = Int(mainString[endIndex].asciiValue! - aAsciiValue + 1)
        let strRKHash = (preStrRKHash - Int(pow(26.0, Double(subLength - 1))) * preChHashValue) * 26 + endChHashValue
        print("subStr: \"\(mainString[curIndex...endIndex])\" hash: \(strRKHash), rkHash: \(mainString[curIndex...endIndex].rkHashValue)")
        
        // 如果哈希值相等，则找到下标
        if subStrRKHash == strRKHash {
            return i
        }
        preStrRKHash = strRKHash
    }
    
    return nil
}

extension String {
    /// RK算法计算哈希值，设定小写字母，只包含a~z
    var rkHashValue: Int {
        var value = 0
        let lowcaseStr = self.lowercased()
        for (i, ch) in lowcaseStr.reversed().enumerated() {
            let v = ch.asciiValue! - Character("a").asciiValue! + 1
            value += (Int(pow(26.0, Double(i))) * Int(v))
        }
        return value
    }
    
    /// 添加下标快捷操作方法
    subscript(index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}

extension Substring {
    var rkHashValue: Int {
        return String(self).rkHashValue
    }
}
