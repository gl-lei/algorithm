//
//  main.swift
//  LeetCode
//
//  Created by ggl on 2020/6/7.
//  Copyright © 2020 ggl. All rights reserved.
//

import Foundation

print("LeetCode go go!")


print("\n============LeetCode001==============")


print("\n============LeetCode002==============")


print("\n============LeetCode003==============")
let testStringArr = ["abcabcbb", "bbbbb", "pwwkew"]
let solution3 = Solution003()
for str in testStringArr {
    let result = solution3.lengthOfLongestSubstring(str)
    print("\"\(str)\" result: \(result)")
}

print("")
let solution3_1 = Solution003_1()
for str in testStringArr {
    let result = solution3_1.lengthOfLongestSubstring(str)
    print("\"\(str)\" result: \(result)")
}
