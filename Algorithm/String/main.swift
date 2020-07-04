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

print("\n============字符串匹配BM算法==============")
if let result = bmSearch(subString: subString, mainString: mainString) {
    print("BM: found \"\(subString)\" in \"\(mainString)\" at index: \(result).")
} else {
    print("BM: not found \"\(subString)\" in \"\(mainString)\".")
}

print("\n============字符串匹配KMP算法==============")
if let result = kmpSearch(subString: subString, mainString: mainString) {
    print("KMP: found \"\(subString)\" in \"\(mainString)\" at index: \(result).")
} else {
    print("KMP: not found \"\(subString)\" in \"\(mainString)\".")
}
