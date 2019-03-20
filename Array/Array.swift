//
//  Array.swift
//  Array
//
//  Created by ggl on 2019/3/20.
//  Copyright © 2019年 ggl. All rights reserved.
//  数组

import Foundation

class DynamicExpansionArray {
    
    /// 数组底层存储结构
    var array: UnsafeMutablePointer<Int>
    
    /// 数组元素个数
    var size: Int
    
    /// 数组容量大小
    var capcity: Int
    
    /// 初始化方法
    ///
    /// - Parameter capcity: 数组容量大小
    init(capcity: Int) {
        size = 0
        self.capcity = capcity
        array = UnsafeMutablePointer<Int>.allocate(capacity: capcity)
        array.initialize(to: 0)
    }
    
    /// 增加元素
    ///
    /// - Parameter num: 要增加的数字
    func add(num: Int) {
        if size >= capcity {
            let tempArray = array
            array = UnsafeMutablePointer<Int>.allocate(capacity: capcity * 2)
            array.assign(from: tempArray, count: capcity)
            tempArray.deallocate()
            capcity *= 2
        }
        array.advanced(by: size).pointee = num
        size += 1
    }
    
    /// 插入元素
    ///
    /// - Parameters:
    ///   - num: 要增加的数字
    ///   - at: 位置下标
    /// - Returns: 插入是否成功
    func insert(num: Int, at index: Int) -> Bool {
        if index < 0 {
            Swift.print("下标位置错误")
            return false
        }
        
        add(num: num)
        if index < size - 1 {
            //交换位置
            let pNum = array.advanced(by: index).pointee
            array.advanced(by: index).pointee = num
            array.advanced(by: size-1).pointee = pNum
        }
        return true
    }
    
    /// 删除元素
    ///
    /// - Parameter at: 位置下标
    /// - Returns: 是否成功
    func remove(at index: Int) -> Bool {
        if index < 0 || index >= size {
            return false
        }
        for i in index..<size-1 {
            array.advanced(by: i).pointee = array.advanced(by: i+1).pointee
        }
        return true
    }
    
    /// 打印元素
    func print() {
        Swift.print("[", terminator: "")
        for i in 0..<size {
            if i == size - 1 {
                Swift.print(array.advanced(by: size-1).pointee, terminator: "]")
            } else {
                Swift.print(array.advanced(by: i).pointee, terminator: " ")
            }
        }
        Swift.print("")
    }
    
    deinit {
        array.deallocate()
    }
}
