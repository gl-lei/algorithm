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
