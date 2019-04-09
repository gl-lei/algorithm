//
//  ArrayStack.swift
//  Stack
//
//  Created by ggl on 2019/4/8.
//  Copyright © 2019年 ggl. All rights reserved.
//  数组顺序栈

import Foundation

class ArrayStack<Element> {
    
    /// 顺序栈底层结构
    var array: [Element]
    
    /// 元素的个数
    var count: Int {
        return array.count
    }
    
    init() {
        array = []
    }
    
    /// 元素入栈
    ///
    /// - Parameter item: 需要入栈的元素
    func push(_ item: Element) {
        array.append(item)
    }
    
    /// 元素出栈
    ///
    /// - Returns: 需要出栈的元素
    @discardableResult
    func pop() -> Element? {
        return array.last
    }
    
    /// 打印元素
    func print() {
        Swift.print("ArrayStack元素（靠前的元素表示栈顶元素）：", terminator: "")
        
        for item in array.reversed() {
            Swift.print(item, terminator: " ")
        }
        Swift.print("")
    }
}
