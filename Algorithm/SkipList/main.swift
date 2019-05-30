//
//  main.swift
//  SkipList
//
//  Created by ggl on 2019/5/29.
//  Copyright © 2019 ggl. All rights reserved.
//

import Foundation

let skipList = SkipList()

print("=========跳表插入数据=========")
for i in 1...48 {
    skipList.insert(value: i)
}

skipList.printAll()

print("\n=========跳表查找数据=========")
let findValue = 30
if let node = skipList.find(value: findValue) {
    print("查找到结点值为\(findValue)的结点: \(node)")
} else {
    print("未查找到结点值为\(findValue)的结点")
}

print("\n=========跳表删除数据=========")
for _ in 0..<10 {
    let value = Int.random(in: 1...48)
    skipList.delete(value: value)
    print("跳表删除结点值为\(value)的结点")
    skipList.printAll()
    print("")
}


