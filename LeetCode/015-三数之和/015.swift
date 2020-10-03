//
//  015.swift
//  LeetCode
//
//  Created by ggl on 2020/10/2.
//  Copyright © 2020 ggl. All rights reserved.
//  015三数之和

import Foundation

/*
* 15. 三数之和
* 题意：给一个包含 n 个整数的数组 nums，判断 nums 中是否存在三个元素 a，b，c ，使得 a + b + c = 0 ？请找出所有满足条件且不重复的三元组。
* 注意：答案中不可以包含重复的三元组。
* 难度：中等
* 分类：数组，双指针
* 算法：当我们需要枚举数组中的两个元素时，如果我们发现随着第一个元素的递增，第二个元素是递减的，那么就可以使用双指针的方法，
       将枚举的时间复杂度从O(N^2)减少至O(N)
*/

/// 第一种解法，暴力循环法，时间复杂度O(N^3)
class Solution015 {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        if nums.count < 3 {
            return result
        }
        var nums = nums
        
        // 1.为保证元素不重复，首先进行排序
        nums.sort()
        
        // 2.暴力三层for循环，O(N^3)
        for i in 0..<nums.count {
            if i > 0 && nums[i-1] == nums[i] {
                continue
            }
            for j in i+1..<nums.count {
                if j > i+1 && nums[j] == nums[j-1] {
                    continue
                }
                for k in j+1..<nums.count {
                    if k > j+1 && nums[k] == nums[k-1] {
                        continue
                    }
                    if nums[i] + nums[j] + nums[k] == 0 {
                        result.append([nums[i], nums[j], nums[k]])
                    }
                }
            }
        }
        return result
    }
}

/// 第二种解法：排序 + 双指针，时间复杂度O(N^2)
class Solution015_1 {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        if nums.count < 3 {
            return result
        }
        
        // 1.排序
        var nums = nums
        nums.sort()
        
        // 2.双指针
        for i in 0..<nums.count {
            if i > 0 && nums[i] == nums[i-1] {
                continue
            }
            
            // 剩下的两数之和目标值
            let target = -nums[i]
            
            // k表示尾指针
            var k = nums.count - 1
            for j in i+1..<nums.count {
                if j > i+1 && nums[j] == nums[j-1] {
                    continue
                }
                
                // 需要保证头指针在尾指针的左边，也就是 j < k
                while j < k && nums[j] + nums[k] > target {
                    k -= 1
                }
                
                // 头尾指针重合，表示无法找到满足的数据，直接退出
                if j == k {
                    break
                }
                
                if nums[j] + nums[k] == target {
                    result.append([nums[i], nums[j], nums[k]])
                }
            }
            
        }
        return result
    }
}
