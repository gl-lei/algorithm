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
let testNums001 = [2, 7, 11, 15]
let testNumTarget = 9
let solution001 = Solution001()
let result001 = solution001.twoSum(testNums001, testNumTarget)
print("num: \(testNums001), target: \(testNumTarget), result: \(result001)")

print("\n============LeetCode002==============")
let testLinkNode002 = Solution002.ListNode(2)
testLinkNode002.next = Solution002.ListNode(4)
testLinkNode002.next?.next = Solution002.ListNode(3)

let testLinkNode002_1 = Solution002.ListNode(5)
testLinkNode002_1.next = Solution002.ListNode(6)
testLinkNode002_1.next?.next = Solution002.ListNode(4)

let solution002 = Solution002()
let result002Node = solution002.addTwoNumbers(testLinkNode002, testLinkNode002_1)
print("链表1: ", terminator: ""); solution002.print(node: testLinkNode002)
print("链表2: ", terminator: ""); solution002.print(node: testLinkNode002_1)
print("求和结果: ", terminator: ""); solution002.print(node: result002Node)

print("\n============LeetCode003==============")
let testStringArr = ["abcabcbb", "bbbbb", "pwwkew"]
let solution003 = Solution003()
for str in testStringArr {
    let result = solution003.lengthOfLongestSubstring(str)
    print("\"\(str)\" result: \(result)")
}

print("")
let solution003_1 = Solution003_1()
for str in testStringArr {
    let result = solution003_1.lengthOfLongestSubstring(str)
    print("\"\(str)\" result: \(result)")
}

print("\n============LeetCode015==============")
let solution015 = Solution015()
let testNums015 = [-1, 0, 1, 2, -1, -4]
let result = solution015.threeSum(testNums015)
print(result)

let solution015_1 = Solution015_1()
let result1 = solution015_1.threeSum(testNums015)
print(result1)

print("\n============LeetCode020==============")
let solution020 = Solution020()
let testChArr = ["()", "()[]{}", "(]", "([)]", "{[]}"]
for str in testChArr {
    print(solution020.isValid(str), terminator: " ")
}
print("")

print("\n============LeetCode023==============")
let testLinkNode023 = Solution023.ListNode(1)
testLinkNode023.next = Solution023.ListNode(4)
testLinkNode023.next?.next = Solution023.ListNode(5)

let testLinkNode023_1 = Solution023.ListNode(1)
testLinkNode023_1.next = Solution023.ListNode(3)
testLinkNode023_1.next?.next = Solution023.ListNode(4)

let testLinkNode023_2 = Solution023.ListNode(2)
testLinkNode023_2.next = Solution023.ListNode(6)

let testArr023 = [testLinkNode023, testLinkNode023_1, testLinkNode023_2]
let solution023 = Solution023()
var linkNode = solution023.mergeKLists(testArr023)
if linkNode != nil {
    print(linkNode!.val, terminator: "")
    linkNode = linkNode?.next
}
while linkNode != nil {
    print(" -> \(linkNode!.val)", terminator: "")
    linkNode = linkNode?.next
}
print("")

print("\n============LeetCode041==============")
let testNums041 = [[1, 2, 0], [3, 4, -1, 1], [7, 8, 9, 11, 12]]
let solution041 = Solution041()
let solution041_1 = Solution041_1()
for nums in testNums041 {
    print(solution041.firstMissingPositive(nums))
    print(solution041_1.firstMissingPositive(nums));
}

print("\n============LeetCode141==============")
// 循环链表 3 -> 2 -> 0 -> -4
let testLinkNode141 = Solution141.ListNode(3)
testLinkNode141.next = Solution141.ListNode(2)
testLinkNode141.next?.next = Solution141.ListNode(0)
testLinkNode141.next?.next?.next = Solution141.ListNode(-4)
testLinkNode141.next?.next?.next?.next = testLinkNode141.next

// 循环链表 1 -> 2
let testLinkNode141_1 = Solution141.ListNode(1)
testLinkNode141_1.next = Solution141.ListNode(2)
testLinkNode141_1.next?.next = testLinkNode141

// 单链表 1
let testLinkNode141_2 = Solution141.ListNode(1)

let testArr141 = [testLinkNode141, testLinkNode141_1, testLinkNode141_2]
let solution141 = Solution141()
let solution141_1 = Solution141_1()
let solution141_2 = Solution141_2()

for linkNode in testArr141 {
    print(solution141.hasCycle(linkNode), solution141_1.hasCycle(linkNode), solution141_2.hasCycle(linkNode))
}

print("\n============LeetCode169==============")
let testNums169 = [[3, 2, 3], [2, 2, 1, 1, 1, 2, 2]]
let solution169 = Solution169()
let solution169_1 = Solution169_1()
let solution169_2 = Solution169_2()
let solution169_3 = Solution169_3()
for nums in testNums169 {
    print("\(nums): ", terminator: "")
    print(solution169.majorityElement(nums), solution169_1.majorityElement(nums),
          solution169_2.majorityElement(nums), solution169_3.majorityElement(nums))
}
