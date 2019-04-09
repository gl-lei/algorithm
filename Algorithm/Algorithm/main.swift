//
//  main.swift
//  Algorithm
//
//  Created by ggl on 2019/3/18.
//  Copyright © 2019年 ggl. All rights reserved.
//

import Foundation

print("数据结构与算法之美!")

var array = UnsafeMutableBufferPointer<String>.allocate(capacity: 2)
var firstItem = array.baseAddress!
firstItem.pointee = "Hello World"

firstItem.advanced(by: 1).pointee = "北京欢迎您，北京欢迎您，北京欢迎您，北京欢迎您，北京欢迎您，北京欢迎您"


print(firstItem[0])
print(firstItem[1])

defer {
    array.deallocate()
}


