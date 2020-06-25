//
//  main.swift
//  String
//
//  Created by ggl on 2020/6/25.
//  Copyright © 2020 ggl. All rights reserved.
//

import Foundation

print("============字符串匹配BF算法==============")
let subString = "abc"
let mainString = "baddeabcf"
if let result = bfSearch(subString: subString, mainString: mainString) {
    print("BF: found \"\(subString)\" in \"\(mainString)\" at index: \(result).")
} else {
    print("BF: not found \"\(subString)\" in \"\(mainString)\".")
}

print("\n============字符串匹配RK算法==============")
if let result = rkSearch(subString: subString, mainString: mainString) {
    print("RK: found \"\(subString)\" in \"\(mainString)\" at index: \(result).")
} else {
    print("RK: not found \"\(subString)\" in \"\(mainString)\".")
}

