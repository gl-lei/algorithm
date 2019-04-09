//
//  Array.swift
//  Array
//
//  Created by ggl on 2019/3/20.
//  Copyright © 2019年 ggl. All rights reserved.
//  大小固定的有序动态扩容数组

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
    }
    
    /// 增加元素
    ///
    /// - Parameter num: 要增加的数字
    func add(num: Int) {
        if size >= capcity {
            let tempArray = array
            array = UnsafeMutablePointer<Int>.allocate(capacity: capcity * 2)
            array.assign(from: tempArray, count: size)
            tempArray.deallocate()
            capcity *= 2
        }
        array[size] = num
        size += 1
    }
    
    /// 插入元素
    ///
    /// - Parameters:
    ///   - num: 要增加的数字
    ///   - at: 位置下标
    /// - Returns: 插入是否成功
    @discardableResult
    func insert(num: Int, at index: Int) -> Bool {
        if index < 0 {
            Swift.print("下标位置错误")
            return false
        }
        
        add(num: num)
        if index < size - 1 {
            //交换位置
            let pNum = array[index]
            array[index] = num
            array[size-1] = pNum
        }
        return true
    }
    
    /// 删除元素
    ///
    /// - Parameter at: 位置下标
    /// - Returns: 是否成功
    @discardableResult
    func remove(at index: Int) -> Bool {
        if index < 0 || index >= size {
            return false
        }
        for i in index..<size-1 {
            array[i] = array[i+1]
        }
        size -= 1
        return true
    }
    
    /// 打印元素
    func print() {
        Swift.print("[", terminator: "")
        for i in 0..<size {
            if i == size - 1 {
                Swift.print(array[size-1], terminator: "]")
            } else {
                Swift.print(array[i], terminator: " ")
            }
        }
        Swift.print("")
    }
    
    deinit {
        array.deallocate()
    }
}
