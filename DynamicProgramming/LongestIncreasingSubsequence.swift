//
//  LongestIncreasingSubsequence.swift
//  DynamicProgramming
//
//  Created by ggl on 2020/8/29.
//  Copyright © 2020 ggl. All rights reserved.
//  最长递增子序列

import Foundation

/**
 * 我们有一个数字序列包含 n 个不同的数字，如何求出这个序列中的最长递增子序列长度？
 * 比如 2, 9, 3, 6, 5, 1, 7 这样一组数字序列，它的最长递增子序列就是 2, 3, 5, 7，
 * 所以最长递增子序列的长度是 4。
 */

/// 动态规划求解最长递增子序列
/// 递推公式:
/// 定义dp[i]为以A[i]为结尾的最长递增子序列
/// 求解dp[i]，需要从i的位置往前找索引j，满足A[j] < A[i]，则dp[i] = max(dp[i], dp[j]+1)
///
/// - Parameter nums: 数字序列
/// - Returns: 最长递增子序列的长度
func lisDistanceDP(nums: [Int]) -> Int {
    if nums.count < 2 {
        return nums.count
    }
    
    // countArray[i]表示以nums[i]结尾的最长递增子序列长度
    var countArray = [Int](repeating: 1, count: nums.count)
    
    for i in 0..<nums.count {
        for j in 0..<i {
            // 递推公式：满足A[j] < A[i]，则dp[i] = max(dp[i], dp[j]+1)
            if nums[j] < nums[i] {
                countArray[i] = Swift.max(countArray[i], countArray[j]+1)
            }
        }
    }
    
    // 返回结果
    if let max = countArray.max() {
        return max
    }
    
    return 1
}


/// 回溯算法计算最大递增子序列的长度，未进行优化
///
/// - Parameter nums: 数字序列
/// - Returns: 数字序列的最长递增子序列的长度
func lisDistance(nums: [Int]) -> Int {
    recurLisDistance(nums: nums, curIndex: 0, maxNum: 0, preCount: 0)
    return maxLisDist
}


// 最大递增子序列的长度
private var maxLisDist = Int.min

/// 回溯算法内部递归计算
///
/// - Parameters:
///   - nums: 数字序列
///   - curIndex: 当前阶段，当前决策的元素下标
///   - maxNum: 当前决策的最大元素
///   - preCount: 前一次决策后的序列长度
private func recurLisDistance(nums: [Int], curIndex: Int, maxNum:Int, preCount: Int) {
    // 如果当前决策到数组的长度，则比较最大值
    if curIndex >= nums.count {
        if maxLisDist < preCount {
            maxLisDist = preCount
        }
        return
    }
    
    // 当前需要决策的元素
    let curNum = nums[curIndex]
    if curIndex == 0 {
        // 直接决策下一个元素
        recurLisDistance(nums: nums, curIndex: curIndex+1, maxNum: curNum, preCount: 1)
    } else {
        if curNum > maxNum {
            // 当前决策元素大于之前决策的最大值，则有两种处理方式：
            // 1.选取当前元素，将当前元素作为序列的最大值，继续进行下次决策；
            // 2.不选取当前元素，之前序列的最大值依旧为最大值，继续进行下次决策；
            recurLisDistance(nums: nums, curIndex: curIndex+1, maxNum: curNum, preCount: preCount + 1)
            recurLisDistance(nums: nums, curIndex: curIndex+1, maxNum: maxNum, preCount: preCount)
        } else {
            // 当前决策元素小于等于之前决策的最大值，也有两种处理方式：
            // 1.不选取当前元素，之前序列的最大值依旧为最大值，继续进行下次决策；
            // 2.以当前作为新的序列最大值，继续进行下次决策；
            recurLisDistance(nums: nums, curIndex: curIndex+1, maxNum: maxNum, preCount: preCount)
            recurLisDistance(nums: nums, curIndex: curIndex+1, maxNum: curNum, preCount: 1)
        }
    }
}
