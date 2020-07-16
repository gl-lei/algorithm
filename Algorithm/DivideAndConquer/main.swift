//
//  main.swift
//  DivideAndConquer
//
//  Created by ggl on 2020/7/16.
//  Copyright © 2020 ggl. All rights reserved.
//

import Foundation

print("============分治算法==============")
var randomArray = [Int]()
for _ in 0..<6 {
    randomArray.append(Int.random(in: 0...10))
}

let result = countingReversedOrderCount(arr: randomArray)
print("\(randomArray) 的逆序对个数为：\(result)")
