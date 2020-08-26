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
///
/// - Parameter triangleItems: 杨辉三角数据数组
/// - Returns: 求解的最短路径
func yanghuiTriangleShortestPath(triangleItems: [Int]) -> Int {
    // 求解最后一个元素所在的行有几个元素，就申请多大的空间，注意可能个数会不满
    // 最后一行的最大结点个数，也代表总共有几行
    let maxCount = triangleRow(from: triangleItems.count-1)
    // 最后一行的第一个结点下标(从0开始)
    let endRowStartIndex = maxCount * (maxCount - 1) / 2
    // 最后一行的结点个数
    let trueCount = triangleItems.count - endRowStartIndex
    
    // 状态数组，存储当前行所有结点的最短路径长度
    var states = [Int](repeating: 0, count: trueCount)
    
    // 设置第一行结点的最短路径
    states[0] = triangleItems[0]
    
    // 设置剩下行的最短路径
    for row in 2...maxCount {
        // 行的元素在数组中最小下标和最大下标
        let startIndex = row * (row - 1) / 2
        let endIndex = startIndex + row - 1
        
        // 防止杨辉三角不满的情况出现，只需要计算最后一行最大的元素个数的最短路径即可
        let tureIndex = Swift.min(endIndex, startIndex + trueCount - 1)
        
        // 计算最短路径，一定要注意是逆序计算，否则会导致重复计算
        for i in (startIndex...tureIndex).reversed() {
            if i == startIndex {
                // 如果是起始结点
                states[i-startIndex] = states[0] + triangleItems[i]
            } else if i == endIndex {
                // 如果是终止结点
                // row - 2 表示的是上一行的终止结点在states数组中的索引位置
                states[i-startIndex] = states[row-2] + triangleItems[i]
            } else {
                // 中间的结点，需要判断上两个结点最短路径的大小
                // 上一行的元素起始下标
                let topStartIndex = startIndex - row + 1
                
                // 结点在states数组中的索引
                let topLeftIndex = (i - row) - topStartIndex
                let topRightIndex = topLeftIndex + 1
                
                // 取两者之间路径较小者
                let minValue = Swift.min(states[topLeftIndex], states[topRightIndex])
                states[i-startIndex] = minValue + triangleItems[i]
            }
        }
    }
    
    // 返回最短路径
    var shortestPath = states[0]
    
    // 防止数组不满，需要注意最后一行中的结点个数
    print("最后一行各个结点的最短路径: \(states)")
    for i in 1..<trueCount {
        if states[i] < shortestPath {
            shortestPath = states[i]
        }
    }
    return shortestPath
}


//MARK: - 回溯算法求解


// 最短路径
private var recurShortestPath = Int.max

// 杨辉三角最后一行的最大下标，防止出现不满的情况
private var endRowMaxEndIndex = 0

/// 利用回溯算法求解杨辉三角最短路径问题
///
/// - Parameter triangleItems: 杨辉三角数据数组
/// - Returns: 最短路径
func yanghuiTriangleShortestPath2(triangleItems: [Int]) -> Int {
    // 最后一行的行数，从1开始
    let rowNum = triangleRow(from: triangleItems.count-1)
    endRowMaxEndIndex = rowNum * (rowNum - 1) / 2 + rowNum - 1
    
    // 递归计算
    recurPath(items: triangleItems, curIndex: 0, length: 0)
    return recurShortestPath
}

/// 递归求解最短路径问题
///
/// - Parameters:
///   - items: 杨辉三角数据数组
///   - curIndex: 当前路径结点在杨辉三角数组中的下标
///   - length: 当前结点路径长度
private func recurPath(items:[Int], curIndex: Int, length: Int) {
    // 已达到最终位置
    if curIndex >= items.count {
        // 结点下标必须要大于最后一行结点全满时的最大下标才可以
        if length < recurShortestPath && curIndex > endRowMaxEndIndex {
            recurShortestPath = length
        }
        return
    }
    
    // 选择左路径
    let leftIndex = triangleRow(from: curIndex) + curIndex
    recurPath(items: items, curIndex:leftIndex , length: length + items[curIndex])
    
    // 选择右路径
    let rightIndex = leftIndex + 1
    recurPath(items: items, curIndex: rightIndex, length: length + items[curIndex])
}

//MARK: - Private Methods

/// 根据杨辉三角的特性，通过下标求解当前元素所在的行数(从1开始)
///
/// - Parameter index: 元素位置索引
/// - Returns: 当前元素所在的行数(从1开始)
private func triangleRow(from index: Int) -> Int {
    // 根据 n*(n-1)/2(n表示结点的下标，从0开始) 规律来求解出当前下标元素所在的行，
    // 则相邻的下面两个元素则是 index+n 和 index+n+1
    // 上面的元素是 index-n 和 index-n+1
    var i = 1
    while i * (i-1) <= index * 2 {
        i = i + 1
    }
    return i - 1
}
