//
//  001.swift
//  LeetCode
//
//  Created by ggl on 2020/6/7.
//  Copyright © 2020 ggl. All rights reserved.
//  001两数之和

import Foundation

/*
 * 1. 两数之和
 * 题意：返回数组中和为给定数的下标
 * 难度：Easy
 * 分类：Array, HashTable
 * 算法：题目说明了数组中一定有解，且解唯一，所以用哈希表记录已遍历的元素即可
 */

class Solution001 {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var maps = [Int: Int]()
        for (i, num) in nums.enumerated() {
            if let index = maps[target - num] {
                return [i, index]
            }
            maps[num] = i
        }
        return []
    }
}
