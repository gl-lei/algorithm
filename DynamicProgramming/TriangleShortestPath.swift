//
//  TriangleShortestPath.swift
//  DynamicProgramming
//
//  Created by ggl on 2020/8/22.
//  Copyright © 2020 ggl. All rights reserved.
//  最短路径

import Foundation

/// 动态规划求解杨辉三角最短路径，时间复杂度O(N)，空间复杂度O(N),N表示元素个数
/// 利用杨辉三角的规律，可以降低空间复杂度
///
/// - Parameter triangleItems: 杨辉三角数据数组
/// - Returns: 求解的最短路径
func yanghuiTriangleShortestPath(triangleItems: [Int]) -> Int {
    // 求解最后一个元素所在的行，也就是有几个元素
    let maxCount = triangleRow(from: triangleItems.count-1)
    // 状态数组，存储当前行所有结点的最短路径长度
    var states = [Int](repeating: 0, count: maxCount)
    
    // 设置第一行结点的最短路径
    states[0] = triangleItems[0]
    
    // 设置剩下行的最短路径
    for row in 2...maxCount {
        // 行的元素在数组中最小下标和最大下标
        let startIndex = row * (row - 1) / 2
        let endIndex = startIndex + row - 1
        
        // 计算最短路径，一定要注意是逆序计算，否则会导致重复计算
        for i in (startIndex...endIndex).reversed() {
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
    for i in 1..<maxCount {
        if states[i] < shortestPath {
            shortestPath = states[i]
        }
    }
    print("最后一行各个结点的最短路径: \(states)")
    return shortestPath
}


//MARK: - 回溯算法求解


// 最短路径
private var recurShortestPath = Int.max

/// 利用回溯算法求解杨辉三角最短路径问题
///
/// - Parameter triangleItems: 杨辉三角数据数组
/// - Returns: 最短路径
func yanghuiTriangleShortestPath2(triangleItems: [Int]) -> Int {
    recurPath(items: triangleItems, curIndex: 0, length: 0)
    return recurShortestPath
}

/// 递归求解最短路径问题
///
/// - Parameters:
///   - items: 杨辉三角数据数组
///   - curIndex: 当前路径结点下标
///   - length: 当前路径长度
private func recurPath(items:[Int], curIndex: Int, length: Int) {
    // 已达到最终位置
    if curIndex >= items.count {
        if length < recurShortestPath {
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
    // 根据 n*(n+1)/2 规律来求解出当前下标元素所在的行，
    // 则相邻的下面两个元素则是 index+n 和 index+n+1
    // 上面的元素是 index-n 和 index-n+1
    var i = 1
    while i * (i-1) <= index * 2 {
        i = i + 1
    }
    return i - 1
}




