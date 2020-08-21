//
//  Queens.swift
//  Backtrack
//
//  Created by ggl on 2020/8/19.
//  Copyright © 2020 ggl. All rights reserved.
//  八皇后问题(回溯算法)

import Foundation

// 八皇后问题(共96种解法)
private let nQueen = 8

// result数组表示row行的棋子放到了哪一列
private var result = [Int](repeating: -1, count: nQueen)

/// 计算八皇后问题
func cal8Queens() {
    cal8Queens(row: 0)
}

/// 递归计算八皇后问题
///
/// - Parameter row:  从哪一行开始
private func cal8Queens(row: Int) {
    // 所有棋子放置好后，打印
    if row == nQueen {
        printQueens()
        return
    }
    
    // 每一行中都有nQueue种放法
    for column in 0..<nQueen {
        if isOK(row: row, column: column) {
            result[row] = column
            cal8Queens(row: row+1)
        }
    }
}

/// row行column列放置皇后是否合适
///
/// - Parameters:
///   - row: 行索引
///   - column: 列索引
/// - Returns: 是否合适
private func isOK(row: Int, column: Int) -> Bool {
    var leftUp = column - 1, rightUp = column + 1
    
    // 逐行往上考察每一行
    for i in (0..<row).reversed() {
        // 考察直线位置
        if result[i] == column {
            return false
        }
        
        // 考察左上角位置
        if leftUp >= 0 && result[i] == leftUp {
            return false
        }
        
        // 考察右上角位置
        if rightUp < nQueen && result[i] == rightUp {
            return false
        }
        leftUp -= 1
        rightUp += 1
    }
    return true
}

/// 打印皇后二维矩阵
private func printQueens() {
    for row in 0..<nQueen {
        for column in 0..<nQueen {
            if result[row] == column {
                print("Q ", terminator: "")
            } else {
                print("* ", terminator: "")
            }
        }
        print("")
    }
    print("")
}

