//
//  MergeTwoSortedArray.swift
//  Array
//
//  Created by ggl on 2019/3/21.
//  Copyright © 2019年 ggl. All rights reserved.
//

import Foundation

/// 合并两个有序数组为一个有序数组
///
/// - Parameters:
///   - arrOne: 第一个有序数组
///   - arrOneCount: 第一个有序数组的大小
///   - arrTwo: 第二个有序数组
///   - arrTwoCount: 第二个有序数组的大小
/// - Returns: 新的有序数组(需要释放)
func mergeTwoSortedArray(arrOne: UnsafePointer<Int>, arrOneCount: Int, arrTwo: UnsafePointer<Int>, arrTwoCount: Int) -> UnsafePointer<Int> {
    let newArray = UnsafeMutablePointer<Int>.allocate(capacity: arrOneCount + arrTwoCount)
    
    var i = 0, j = 0
    for index in 0..<(arrOneCount + arrTwoCount) {
        // 判断i和j有没有到头
        if i > arrOneCount-1 {
            newArray[index] = arrTwo[j]
            j += 1
        } else if j > arrTwoCount-1 {
            newArray[index] = arrOne[i]
            i += 1
        } else {
            let num1 = arrOne[i]
            let num2 = arrTwo[j]
            if num1 > num2 {
                newArray[index] = num2
                j += 1
            } else {
                newArray[index] = num1
                i += 1
            }
        }
    }
    return UnsafePointer(newArray)
}

/// 合并两个有序数组
/// - Parameters:
///   - arr: 有序的第一个数组
///   - otherArr: 有序的第二个数组
/// - Returns: 有序的合并数组
func mergeTwoSortedArray(_ arr: [Int], _ otherArr: [Int]) -> [Int] {
    var i = 0, j = 0
    var resultArr = [Int]()
    while i < arr.count || j < otherArr.count {
        if i == arr.count {
            // arr 数组到头了，只需要添加 otherArr 中的元素
            print(otherArr[j])
            resultArr.append(otherArr[j])
            j += 1
        } else if j == otherArr.count {
            // otherArr 数组到头了，只需要添加 arr 中的元素
            print(arr[i])
            resultArr.append(arr[i])
            i += 1
        } else {
            // 比较两者大小
            if arr[i] > otherArr[j] {
                print(otherArr[j])
                resultArr.append(otherArr[j])
                j += 1
            } else {
                print(arr[i])
                resultArr.append(arr[i])
                i += 1
            }
        }
    }
    
    return resultArr
}

/// 打印数组内容
///
/// - Parameter arr: 数组
func printArray(arr: UnsafePointer<Int>, count: Int) {
    if count == 0 {
        print("[]")
        return
    }
    
    print("[", terminator: "")
    for i in 0..<count {
        if i == count - 1 {
            print(arr[count-1], terminator: "]\n")
        } else {
            print(arr[i], terminator: " ")
        }
    }
}
