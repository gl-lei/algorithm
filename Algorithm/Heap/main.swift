//
//  main.swift
//  Heap
//
//  Created by ggl on 2020/6/10.
//  Copyright © 2020 ggl. All rights reserved.
//

import Foundation

print("============堆结构与堆排序==============")
let count = 10
let maxHeap = Heap<Int>(type: .max, capacity: count)
let minHeap = Heap<Int>(type: .min, capacity: count)

// 随机生成10个数
var maxHeapArr = [Int]();
for _ in 0..<count {
    let num = Int.random(in: 1...100)
    maxHeap.insert(num)
    maxHeapArr.append(num)
}

var minHeapArr = [Int]();
for _ in 0..<count {
    let num = Int.random(in: 1...100)
    minHeap.insert(num)
    minHeapArr.append(num)
}

print("大根堆=>", terminator:"")
maxHeap.print()

print("小根堆=>", terminator:"")
minHeap.print()

print("\n============堆排序==============")
print("未排序之前数据：", terminator: "")
for i in maxHeapArr {
    print("\(i) ", terminator: "")
}
print("")

heapSort(&maxHeapArr)
print("排完序之后数据：", terminator: "")
for i in maxHeapArr {
    print("\(i) ", terminator: "")
}
print("\n")

print("\n============合并K个有序数组==============")

var arr = [[Int]]()
for _ in 0..<10 {
    var arr1 = [Int]()
    for _ in 5...10 {
        arr1.append(Int.random(in: 0...100))
    }
    arr1.sort(by: <)
    arr.append(arr1)
}
print("未合并之前的数据：\(arr)\n")
let resultArr = mergeKSortedArray(arr)
print("\n合并K个有序数组后排序结果：\(resultArr)")


print("\n============求一组动态数据集合的最大Top K==============")
let dynHeap = Heap<Int>(type: .min, capacity: 10)
for i in arr.flatMap({ $0 }) {
    dynHeap.insert(i)
}
print("动态数据数据集合的最大Top K结果(插入的数据)")
dynHeap.print()
