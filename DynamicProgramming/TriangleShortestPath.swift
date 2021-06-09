//
//  TriangleShortestPath.swift
//  DynamicProgramming
//
//  Created by ggl on 2020/8/22.
//  Copyright © 2020 ggl. All rights reserved.
//  杨辉三角最短路径

import Foundation

/**
 * “杨辉三角”不知道你听说过吗？我们现在对它进行一些改造。
 * 每个位置的数字可以随意填写，经过某个数字只能到达下面一层相邻的两个数字。
 * 假设你站在第一层，往下移动，我们把移动到最底层所经过的所有数字之和，
 * 定义为路径的长度。请你编程求出从最高层移动到最底层的最短路径长度。
 */

/// 动态规划求解杨辉三角最短路径，时间复杂度O(N)，空间复杂度O(N),N表示元素个数
/// 利用杨辉三角的规律，可以降低空间复杂度
/// [5]
/// [7, 8]
/// [2, 3, 4]
/// [4, 9, 6, 1]
/// [2, 7, 9, 4, 5]
///
/// - Parameter triangleItems: 杨辉三角数据数组
/// - Returns: 求解的最短路径
func yanghuiTriangleShortestPath(_ triangleItems: [[Int]]) -> Int {
    // 使用动态规划的方式来解决，最小路径和和最大路径和比较适合使用自底向上的结构
    // 递推公式：f(i,j) = min(f(i+1,j), f(i+1,j+1)) + value(i,j)，i表示层，j表示层中的列，
    // f(i,j)表示i层j列的最小路径和，value(i,j) 表示i,j位置的值。
    let count = triangleItems.count
    var states = [Int](repeating: 0, count: count)
    // 初始化最后一层的数据
    for i in 0..<triangleItems[count-1].count {
        states[i] = triangleItems[count-1][i]
    }
    
    // 自底向上计算最小路径
    for i in (0..<count-1).reversed() {
        for j in 0..<triangleItems[i].count {
            states[j] = Swift.min(states[j], states[j+1]) + triangleItems[i][j]
        }
    }
    
    return states[0]
}


//MARK: - 回溯算法求解

/// 利用回溯算法求解杨辉三角最短路径问题
///
/// - Parameter triangleItems: 杨辉三角数据数组
/// - Returns: 最短路径
func yanghuiTriangleShortestPath2(_ triangleItems: [[Int]]) -> Int {
    return recurShortestPath(triangleItems, i: 0, j: 0)
}

/// 求解(i,j)的最短路径
/// - Parameters:
///   - items: 杨辉三角数据数组
///   - i: 层下标
///   - j: 列下标
/// - Returns: i层j列的最短路径值
private func recurShortestPath(_ items:[[Int]], i: Int, j: Int) -> Int {
    if i == items.count - 1 {
        return items[i][j]
    }
    let leftValue = recurShortestPath(items, i: i+1, j: j)
    let rightValue = recurShortestPath(items, i: i+1, j: j+1)
    return Swift.min(leftValue, rightValue) + items[i][j]
}
