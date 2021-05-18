//
//  RecursionFunc.swift
//  Recursion
//
//  Created by ggl on 2019/4/15.
//  Copyright © 2019年 ggl. All rights reserved.
//  递归

import Foundation

// 斐波那契数列 防止重复计算，防止堆栈溢出
var info = [Int: Int]()
func fibonacciSeriesRecur(n: Int) -> Int {
    // 递归终止条件
    if n < 0 {
        return 0
    }
    let result = [0, 1]
    if n < 2 {
        return result[n]
    }
    
    // 先从字典中获取（优化重复计算问题）
    if let num = info[n] {
        return num
    }
    
    // 字典中如果没有的话，则计算结果
    let sum = fibonacciSeriesRecur(n: n - 1) + fibonacciSeriesRecur(n: n - 2)
    info[n] = sum
    return sum
}

/// 迭代写法
func fibonacciSeries(n: Int) -> Int {
    if n < 0 {
        return 0;
    }
    
    let result = [0, 1]
    if n < 2 {
        return result[n]
    }
    
    // 通过for循环来计算
    var fibonacciOne = 0
    var fibonacciTwo = 1
    var fibonacciN = 0
    for _ in 2...n {
        fibonacciN = fibonacciOne + fibonacciTwo
        fibonacciOne = fibonacciTwo
        fibonacciTwo = fibonacciN
    }
    
    return fibonacciN
}

/// 阶乘问题
func factorial(n: Int) -> Double {
    if n < 0 {
        return 0
    }
    
    if n == 0 {
        return 1
    }
    
    var result: Double = 1
    for i in 2...n {
        result *= Double(i)
    }
    
    return result
}

/// 数据集合从k到m位置的全排列
/// 具体解读：https://blog.csdn.net/qq_42119136/article/details/104641424
/// 集合的全排列定义：集合(1,2,3)的所有排列为(1,2,3)(1,3,2)(2,1,3)(2,3,1)(3,1,2)(3,2,1)
/// - Parameters:
///   - array: 数据集合
///   - k: 移动起始位置
///   - m: 移动终止位置
func permutation(_ array: inout [Int], _ k: Int, _ m: Int) {
    if k == m {
        // 元素全部都处于非移动区，打印集合
        print(array)
    } else {
        for i in k...m {
            // 依次让i指向的元素与k指向的元素交换位置，然后i指向下一个元素，k指向元素再与之交换
            array.swapAt(k, i)
            
            // 向移动区移动，求k+1位置的全排列组合
            permutation(&array, k+1, m)
            
            // 数据还原回初始状态
            array.swapAt(k, i)
        }
    }
}

/*
 假如这里有 n 个台阶，每次你可以跨 1 个台阶或者 2 个台阶，请问走这 n 个台阶有多少种走法？
 */

/// 递归计算n个台阶的走法
/// 解决思路：假设总共有10个台阶，在第9个台阶处我们假设有 f(9)种走法（也就是走到第9个台阶不同的步数），第8个台阶处有
/// f(8)种走法，f(8)和f(9)是没有重复的走法的，因为它们的终点不同！！
/// f(9) 走到第10个台阶的地方只能再走一步；f(8)走到第10个台阶的地方只能再走两步，为什么不能走一步呢？因为这样的话就会和
/// f(9)的走法重复；另外，f(7)，f(6)...的走法都包含在 f(9) 和 f(8) 的走法种（绕不过去），所以 f(10) = f(9) + f(8)，也就是斐波那契数列
///
/// - Parameter total: 台阶的总数
/// - Returns: 总走法
var stepInfo = [Int: Int]()
func calculateSteps(_ total: Int) -> Int {
    // 一个台阶之后一种走法：走一步
    if total == 1 {
        return 1
    }
    
    // 两个台阶有两种走法：一次走两步或者一次走一步
    if total == 2 {
        return 2
    }
    
    // 解决重复计算的问题
    if stepInfo.keys.contains(total) {
        return stepInfo[total]!
    }
    
    let result = calculateSteps(total-1) + calculateSteps(total-2)
    stepInfo[total] = result
    
    return result
}

/// 非递归计算n个台阶的走法
///
/// - Parameter total: 台阶的总数
/// - Returns: 总走法
func calculateStepsNoRecursion(_ total: Int) -> Int {
    if total == 1 {
        return 1
    }
    
    if total == 2 {
        return 2
    }
    
    // f(n) = f(n-1) + f(n-2)，prepare代表f(n-1)，pre代表f(n-2)
    var result = 0
    var prepare = 1
    var pre = 2
    for _ in 3...total {
        result = pre + prepare
        prepare = pre
        pre = result
    }
    return result
}

/*
 总结：递归代码需要注意的问题：
        1.堆栈溢出（递归层次较深）（通过限制递归深度解决）
        2.重复计算（通过字典保存上一次计算结果解决）
        3.递归死循环（通过散列表检测环的存在）
        4.空间复杂度高（尾递归解决）
 */
