//
//  Set.swift
//  Array
//
//  Created by ggl on 2019/3/20.
//  Copyright © 2019 ggl. All rights reserved.
//  动态扩容的数组(无序)

import Foundation

class DynamicExpansionSet {
    
    /// 底层存储数组
    var array: UnsafeMutablePointer<Int>
    
    /// 元素的个数
    var size: Int
    
    /// 数组的大小
    var capcity: Int
    
    init(capcity: Int) {
        self.capcity = capcity
        array = UnsafeMutablePointer<Int>.allocate(capacity: capcity)
        array.initialize(repeating: Int.min, count: capcity)
        size = 0
    }
    
    /// 增加元素
    ///
    /// - Parameter num: 要增加的数字
    func add(num: Int) {
        if size >= capcity {
            let tempArray = array
            array = UnsafeMutablePointer<Int>.allocate(capacity: capcity * 2)
            array.initialize(repeating: Int.min, count: capcity * 2)
            array.assign(from: tempArray, count: size)
            tempArray.deallocate()
            capcity *= 2
        }
        
        for i in 0..<capcity {
            if array[i] == Int.min {
                array[i] = num
                size += 1
                break
            }
        }
    }
    
    /// 删除元素
    ///
    /// - Parameter num: 删除数字
    /// - Returns: 是否成功
    @discardableResult
    func remove(num: Int) -> Bool {
        if num == Int.min {
            return false
        }
        
        var count = 0
        for i in 0..<capcity {
            guard count < size else {
                return false
            }
            let element = array[i]
            if element == Int.min {
                continue
            }
            
            if num == element {
                array[i] = Int.min
                size -= 1
                return true
            }
            count += 1
        }
        return false
    }
    
    /// 打印元素
    func print() {
        Swift.print("[", terminator: "")
        var count = 0
        for i in 0..<capcity {
            guard count < size else {
                return
            }
            let num = array[i]
            if num != Int.min {
                
                if count == size - 1 {
                    Swift.print(num, terminator: "]\n")
                } else {
                    Swift.print(num, terminator: " ")
                }
                count += 1
            } else {
                continue
            }
        }
    }
    
    deinit {
        array.deallocate()
    }
}

