//
//  169.swift
//  LeetCode
//
//  Created by ggl on 2020/10/2.
//  Copyright © 2020 ggl. All rights reserved.
//  169多数元素

import Foundation

/*
* 169. 多数元素
* 题意：给定一个大小为 n 的数组，找到其中的多数元素。多数元素是指在数组中出现次数大于 ⌊ n/2 ⌋ 的元素。
        你可以假设数组是非空的，并且给定的数组总是存在多数元素。
* 难度：简单
* 分类：哈希表，排序，随机化，摩尔投票法
* 算法：根据多数元素的特征，可以采用哈希表记录元素以及元素对应的出现次数；也可以使用排序，中间对应的数必定为众数；也可以使用分治算法思想，
       求解区间的众数；也可以采用摩尔投票法，最终剩余的元素肯定为众数；
*/

/// 第一种解法：哈希表，时间复杂度O(N)，空间复杂度O(N)
class Solution169 {
    func majorityElement(_ nums: [Int]) -> Int {
        var numMap = [Int: Int]()
        
        // 遍历数组，将元素以及元素对应的个数放入哈希表中
        for num in nums {
            if let value = numMap[num] {
                numMap[num] = value + 1
            } else {
                numMap[num] = 1
            }
        }
        
        // 遍历哈希表，查找出现次数最多的元素
        var moreNum = 0
        var moreCount = 0
        for (num, count) in numMap {
            if count > moreCount {
                moreNum = num
                moreCount = count
            }
        }
        return moreNum
    }
}

/// 第二种解法：排序，时间复杂度O(N*log(N))，空间复杂度log(N)
/// 如果nums数组中所有的数按照递增或者递减的顺序进行排序，则 ⌊ n/2 ⌋ 位置的元素肯定是众数
class Solution169_1 {
    func majorityElement(_ nums: [Int]) -> Int {
        var nums = nums
        nums.sort()
        return nums[nums.count/2]
    }
}

/// 第三种解法：分治算法，时间复杂度O(N*log(N))，空间复杂度O(log(N))
/// 将数组分成左右两部分，分别求出左半部分的众数 a1 以及右半部分的众数 a2，随后在 a1 和 a2 中选出正确的众数。
class Solution169_2 {
    func majorityElement(_ nums: [Int]) -> Int {
        return majorityElementInRange(nums, low: 0, high: nums.count-1)
    }
    
    /// 分治求解众数
    /// - Parameters:
    ///   - nums: 原始数组
    ///   - low: 第一个区间的最小下标
    ///   - high: 第二个区间的最大下标
    /// - Returns: 区间的众数
    private func majorityElementInRange(_ nums: [Int], low: Int, high: Int) -> Int {
        // 如果区间只剩于一个数，直接返回
        if low == high {
            return nums[low]
        }
        
        // 分别求左、右区间的众数，看哪个个数多就返回哪个
        let mid = (low + high) / 2
        let left = majorityElementInRange(nums, low: low, high: mid)
        let right = majorityElementInRange(nums, low: mid+1, high: high)
        
        if left == right {
            return left
        }
        
        // 求左、右区间求出的众数在合并区间的个数
        let leftCount = countInRange(nums, num: left, low: low, high: high)
        let rightCount = countInRange(nums, num: right, low: low, high: high)
        if leftCount > rightCount {
            return left
        } else {
            return right
        }
    }
    
    /// 求众数在区间的个数
    /// - Parameters:
    ///   - nums: 原始数组
    ///   - num: 众数
    ///   - low: 区间的最小下标
    ///   - high: 区间的最大下标
    /// - Returns: 众数在区间的个数
    private func countInRange(_ nums: [Int], num: Int, low: Int, high: Int) -> Int {
        var count = 0
        for i in low...high {
            if nums[i] == num {
                count += 1
            }
        }
        return count
    }
}

/// 第四种解法：摩尔投票法，时间复杂度O(n)，空间复杂度O(1)
/// 如果我们把众数记为 +1，把其他数记为 -1，将它们全部加起来，显然和大于 0，从结果本身我们可以看出众数比其他数多。
class Solution169_3 {
    func majorityElement(_ nums: [Int]) -> Int {
        var count = 0
        var candidate = nums[0]
        for num in nums {
            if count == 0 {
                candidate = num
            }
            count += (num == candidate ? 1 : -1)
        }
        return candidate
    }
}
