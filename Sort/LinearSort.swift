//
//  LinearSort.swift
//  Sort
//
//  Created by ggl on 2019/5/7.
//  Copyright © 2019 ggl. All rights reserved.
//

import Foundation

/// 桶排序
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
    // 桶的区间划分（这里桶的数量与元素数量相同
    // 区间跨度 = (最大值 - 最小值) / (桶的数量)
    // Int类型区域跨度以及数组下标求法：
    //    跨度=(max-min)/bucketNum + 1
    //    下标=(num-min)/跨度
    // Double类型区域跨度以及数组下标求法：
    //    跨度=(max-min)/Double(bucketNum)
    //    下标=(num-min-1)/跨度
    let bucketNum = array.count
    let d = (max - min) / Double(bucketNum)
    print("max: \(max), min: \(min), d = \(d)")
    var bucketTotalArray = [[Double]]()
    for _ in 0..<bucketNum {
        let bucketArray = [Double]()
        bucketTotalArray.append(bucketArray)
    }
    
    // 3.遍历原始数组，将元素放入对应的桶中，并进行排序
    for num in array {
        let n = Int((num - min - 1) / d)
        print("num: \(num) => n: \(n)")
        bucketInnerSort(&bucketTotalArray[n], num: num)
    }
    
    // 4.将排序好的桶元素输出到一个数组中
    var sortedArray = [Double]()
    for bucketArray in bucketTotalArray {
        sortedArray.append(contentsOf: bucketArray)
    }
    
    return sortedArray
}

/// 桶排序内部排序算法（采用插入排序思想）
///
/// - Parameters:
///   - array: 需要插入元素的桶数组
///   - num: 需要插入的元素
func bucketInnerSort(_ array: inout [Double], num: Double) {
    for i in (0..<array.count).reversed() {
        let sortedNum = array[i]
        if sortedNum > num {
            continue
        }
        array.insert(num, at: i+1)
        return
    }
    array.insert(num, at: 0)
}
