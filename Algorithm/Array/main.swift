//
//  main.swift
//  Array
//
//  Created by ggl on 2019/3/20.
//  Copyright © 2019年 ggl. All rights reserved.
//

import Foundation

var array = DynamicExpansionArray(capcity: 10)
for i in 1..<20 {
    array.add(num: i)
}
array.print()

array.insert(num: 30, at: 25)
array.print()

array.insert(num: 31, at: 2)
array.print()

array.remove(at: 1)
array.print()

