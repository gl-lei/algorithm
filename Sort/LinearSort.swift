//
//  LinearSort.swift
//  Sort
//
//  Created by ggl on 2019/5/7.
//  Copyright © 2019 ggl. All rights reserved.
//  桶排序、计数排序和基数排序

import Foundation

/// 桶排序
/// 桶排序的时间复杂度为O(N)
/// 如果需要排序的数据有N个，我们把它们均匀的划分到M个桶里面，每个桶里面就有K=N/M个元素。
/// 每个桶内部使用快速排序，时间复杂度为O(K*logK),M个桶排序的时间复杂度就是O(M*K*logK)，因为K=N/M，所以
/// 整个桶排序的时间复杂度为：O(N*log(N/M))，当桶的个数接近数据个数N时，log(N/M)就是一个非常小的常量，所以
/// 这个时候桶排序的时间复杂度接近O(N)
func bucketSort(_ array: [Double]) -> [Double] {
    if array.isEmpty {
        return array
    }
    
    // 1.遍历数组得到最大值和最小值
    var max = array[0]
    var min = array[0]
    for num in array {
        if num > max {
            max = num
        }
        
        if num < min {
            min = num
        }
    }
    
    // 2.分桶
    // 桶的区间划分
    // 区间跨度 = ceil(最大值 - 最小值 + 1) / (桶的数量)
    // 下标 = (num - min) / 区间跨度
    let bucketNum = array.count
    let d = ceil(max - min + 1) / Double(bucketNum)
    var bucketTotalArray = [[Double]]()
    for _ in 0..<bucketNum {
        let bucketArray = [Double]()
        bucketTotalArray.append(bucketArray)
    }
    
    // 3.遍历原始数组，将元素放入对应的桶中
    for num in array {
        let bucketIndex = Int((num - min) / d)
        bucketTotalArray[bucketIndex].append(num)
    }
    
    // 4. 对每一个桶进行排序
    for i in 0..<bucketNum {
        bucketInnerSort(&bucketTotalArray[i])
    }
    print("桶的个数: \(bucketNum), 桶的内容: \(bucketTotalArray)")
    
    // 5.将排序好的桶元素输出到一个数组中
    var sortedArray = [Double]()
    for bucketArray in bucketTotalArray {
        sortedArray.append(contentsOf: bucketArray)
    }
    
    return sortedArray
}

/// 桶排序内部排序算法
///
/// - Parameters:
///   - array: 需要排序的的桶
func bucketInnerSort(_ array: inout [Double]) {
    array.sort()
}

//MARK: - Counting Sort
/// 计数排序
/// 计数排序只能用在数据范围不大的场景中，数据范围如果比要排序的数据大很多，就不适合用计数排序(数据要有重复)
/// 计数排序只能给非负整数排序，其他类型的话，需要将其在不改变相对大小的情况下，转换为非负整数
/// 例如经典应用：高考查分系统，考生满分是900分，最小是0分，数据范围很小，我们可以分成901个桶
func countingSort(_ array: [Int]) -> [Int] {
    if array.isEmpty {
        return []
    }
    
    // 查找数组中的数据范围，最大值和最小值
    var max = array[0], min = array[0]
    for num in array {
        // 获取最大值
        if num > max {
            max = num
        }
        
        // 获取最小值
        if num < min {
            min = num
        }
    }
    
    // 计算每个元素的重复个数，放入数组中
    var countingArray = [Int](repeating: 0, count: max - min + 1)
    for num in array {
        // 下标从0开始
        let index = num - min
        countingArray[index] += 1
    }
    print("计数排序重复个数信息：\(countingArray)")
    
    // 依次累加数据，进行计数
    for i in 1..<countingArray.count {
        countingArray[i] += countingArray[i-1]
    }
    print("计数排序进行计数之后的信息：\(countingArray)")
    
    // 从后往前遍历，将数据输出到排序数组中，为保证是稳定的排序算法
    var sortArray = [Int](repeating: 0, count: array.count)
    for num in array.reversed() {
        // 计数下标
        let countIndex = num - min
        // 所在排序数组中的下标
        let index = countingArray[countIndex] - 1
        sortArray[index] = num
        countingArray[countIndex] -= 1
    }
    
    return sortArray
}

//MARK: - Radix Sort
/// 基数排序
/// 可以分隔出独立的“位”来比较，而且位之间有递进的关系。每一位的数据范围不能太大，要可以用线性排序算法来排序，否则
/// 基数排序的时间复杂度就无法做到O(n)了。
/// 将所有待比较的数值（正整数）统一为同样的数位长度，数位较短的数前面补零。然后从最低位开始，依次进行一次排序。
/// 这样从最低位一直到最高位排序完成之后，数列就变成了一个有序序列。
/// 基数排序有两种：
///    - LSD(Least significant digital)：最低有效位优先，即从右向左开始排序
///    - MSD(Most significant digital)：最高有效位优先，即从左往右开始排序
///
/// 例如：10万个手机号码从小到大排序，手机号码有11位，范围太大，不适用于桶排序、计数排序
/// 手机号码规律：比较两个手机号码a,b大小，如果在前面几位中，a手机号码已经比b手机号码大，那后面的几位就不用看了
/// 需要注意，按照每位来排序的排序算法要是稳定的
/// 根据每一位来排序，可以使用桶排序或者计数排序，它们的时间复杂度O(n)。如果要排序的数据有K位，那么我们就需要K次桶排序
/// 或者计数排序，总的时间复杂度是O(k*n)
func radixSort(_ array: [Int], _ maxLength: Int) -> [Int] {
    if array.isEmpty {
        return []
    }
    
    var sortArr = array
    for i in 0..<maxLength {
        // 使用计数排序 0～9 总申请共有 10 个桶
        var countingArr = [Int](repeating: 0, count: 10)
        for num in array {
            let index = digit(from: num, distance: i)
            countingArr[index] += 1
        }
        
        // 依次累加数据进行计算
        for i in 1..<10 {
            countingArr[i] += countingArr[i-1]
        }
        
        // 基于之前排序好的数组，重新进行排序
        let preSortArr = sortArr
        for num in preSortArr.reversed() {
            let digitIndex = digit(from: num, distance: i)
            // 所在排序数组中的下标
            let index = countingArr[digitIndex] - 1
            sortArr[index] = num
            countingArr[digitIndex] -= 1
        }
    }
    
    return sortArr
}

/// 获取数字指定位数的数
/// - Parameters:
///   - num: 指定的数
///   - distance: 从右边开始距离的数字，0表示个位，1表示十位...
/// - Returns: 指定位的数字
func digit(from num: Int, distance: Int = 0) -> Int {
    if distance < 0 {
        return num
    }
    
    return num / Int(pow(10, Double(distance))) % 10
}
