//
//  Chessboard.swift
//  DynamicProgramming
//
//  Created by ggl on 2020/8/23.
//  Copyright © 2020 ggl. All rights reserved.
//  棋盘最短路径长度问题

import Foundation

/**
 * 假设我们有一个 n 乘以 n 的矩阵 w[n][n]。矩阵存储的都是正整数。
 * 棋子起始位置在左上角，终止位置在右下角。我们将棋子从左上角移动到右下角。
 * 每次只能向右或者向下移动一位。从左上角到右下角，会有很多不同的路径可以走。
 * 我们把每条路径经过的数字加起来看作路径的长度。
 * 那从左上角移动到右下角的最短路径长度是多少呢？
 */

/// 动态规划求解棋盘最短路径问题(状态转移表)
///
/// - Parameter chessboard: 棋盘数据
/// - Returns: 最短路径
func chessboardMinDistDP(chessboard: [[Int]]) -> Int {
    // 状态二维数组，用来存储每个结点的最短路径长度，x表示棋盘横轴，y表示棋盘纵轴
    var states = [[Int]](repeating: [Int](repeating:0 , count: chessboard.count), count: chessboard.count)
    
    // 初始化第一行数据
    var sum = 0
    for j in 0..<chessboard.count {
        sum += chessboard[0][j]
        states[0][j] = sum
    }
    
    // 初始化第一列数据
    sum = 0
    for i in 0..<chessboard.count {
        sum += chessboard[i][0]
        states[i][0] = sum
    }
    
    // 剩下的其他结点
    for i in 1..<chessboard.count {
        for j in 1..<chessboard.count {
            let minValue = Swift.min(states[i][j-1], states[i-1][j])
            states[i][j] = minValue + chessboard[i][j]
        }
    }
    
    // 返回最小路径
    return states[chessboard.count-1][chessboard.count-1]
}


// 动态规划求解棋盘最短路径问题(状态转移方程法)
/// 状态转移方程，也就是迭代递推方式
/// min_dist(i, j) = w[i][j] + min(min_dist(i, j-1), min(min_dist(i-1, j)))
///
/// - Parameter chessboard: 棋盘数据
/// - Returns: 最短路径
func chessboardMinDistDP1(chessboard: [[Int]]) -> Int {
    // 状态二维数组，用来存储每个结点的最短路径长度
    var states = [[Int]](repeating: [Int](repeating:0 , count: chessboard.count), count: chessboard.count)
    
    // 求解最短路径
    return minDistDP(chessboard: chessboard, states: &states, x: chessboard.count-1, y: chessboard.count-1)
}

/// 根据递推公式递归求解最短路径
///
/// - Parameters:
///   - chessboard: 棋盘数据
///   - states: 状态数组
///   - x: 结点x坐标
///   - y: 结点y坐标
/// - Returns: 当前结点的最短路径
private func minDistDP(chessboard: [[Int]], states: inout [[Int]], x: Int, y: Int) -> Int {
    // 0,0 直接返回
    if x == 0 && y == 0 {
        return chessboard[0][0]
    }
    
    if states[x][y] > 0 {
        return states[x][y]
    }
    
    // 求解左边结点的最短路径
    var minLeft = Int.max
    if y - 1 >= 0 {
        minLeft = minDistDP(chessboard: chessboard, states: &states, x: x, y: y-1)
    }
    
    // 求解上面结点的最短路径
    var minUp = Int.max
    if x - 1 >= 0 {
        minUp = minDistDP(chessboard: chessboard, states: &states, x: x-1, y: y)
    }
    
    let curMinDist = chessboard[x][y] + Swift.min(minLeft, minUp)
    states[x][y] = curMinDist
    return curMinDist
}

// MARK: - 回溯算法计算

// 最短路径长度
private var minDist = Int.max

/// 回溯算法计算棋盘最短路径长度
///
/// - Parameter chessboard: 棋盘数据
/// - Returns: 返回最短路径长度
func chessboardMinDist(chessboard: [[Int]]) -> Int {
    recurMinDist(chessboard: chessboard, x: 0, y: 0, dist: 0)
    return minDist
}

/// 递归计算棋盘最短路径长度
///
/// - Parameters:
///   - chessboard: 棋盘数据
///   - x: 棋盘当前结点的横轴坐标，以右上角为原点
///   - y: 棋盘当前结点的纵轴坐标，以右上角为原点
///   - dist: 当前结点的最短路径(不包括当前结点的值)
private func recurMinDist(chessboard: [[Int]], x: Int, y: Int, dist: Int) {
    // 到达了棋盘终点，计算最短路径
    if x == chessboard.count-1 && y == chessboard.count - 1 {
        // 最短路径
        let finalDist = dist + chessboard[x][y]
        if minDist > finalDist {
            minDist = finalDist
            return
        }
    }
    
    // 不能再继续往下走了
    if x == chessboard.count || y == chessboard.count {
        return
    }
    
    // 往右走
    if x < chessboard.count {
        recurMinDist(chessboard: chessboard, x: x+1, y: y, dist: dist + chessboard[x][y])
    }
    
    // 往下走
    if y < chessboard.count {
        recurMinDist(chessboard: chessboard, x: x, y: y+1, dist: dist + chessboard[x][y])
    }
}
