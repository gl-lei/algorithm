//
//  041.swift
//  LeetCode
//
//  Created by ggl on 2020/10/6.
//  Copyright © 2020 ggl. All rights reserved.
//  041缺失的第一个正数

import Foundation

/*
* 041.缺失的第一个正数
* 题意：给你一个未排序的整数数组，请你找出其中没有出现的最小的正整数。你的算法的时间复杂度应为O(n)，并且只能使用常数级别的额外空间。
* 难度：困难
* 分类：哈希表，原地哈希
* 算法：由于题目要求常数级别的额外空间，故可以使用原地哈希方式，通过标记的方式来完成下标与数值的映射关系
*/


/// 第一种解法：哈希表
/// 原地哈希：f(nums[i]) = nuns[i] - 1，表示数值为i的数映射到下标为i-1的位置
/// 通过打上标记的形式来进行映射
/// 遍历数组，将[1, N]范围内的数修改成任意一个大于N的数，然后我们就可以将标记表示为负号
class Solution041 {
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var nums = nums
        let count = nums.count
        // 将小于等于0的数修改成大于0的正数N+1
        for (i, num) in nums.enumerated() {
            if num <= 0 {
                nums[i] = count + 1
            }
        }
        
        // 打标记
        for num in nums {
            if num <= count {
                nums[num-1] = -Swift.abs(nums[num-1])
            }
        }
        
        // 遍历数组，查找大于0的数，找到则返回下标+1；否则返回N+1
        for (i, num) in nums.enumerated() {
            if num > 0 {
                return i + 1
            }
        }
        return count + 1
    }
}

/// 第二种解法：将对应位置的元素放到对应的位置
class Solution041_1 {
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var nums = nums
        let count = nums.count
        for i in 0..<count {
            // 这里需要使用while，确保交换后的数符合当前位置，如果不符合还要继续交换
            // 还需要注意，交换的两个位置的元素防止造成死循环
            while nums[i] > 0 && nums[i] <= count && nums[i] != nums[nums[i] - 1] {
                nums.swapAt(i, nums[i] - 1)
            }
        }
        
        for (i, num) in nums.enumerated() {
            if num != i + 1 {
                return i + 1
            }
        }
        return count + 1
    }
}
