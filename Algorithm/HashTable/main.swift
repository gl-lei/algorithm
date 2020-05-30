//
//  main.swift
//  HashTable
//
//  Created by ggl on 2019/10/4.
//  Copyright © 2019 ggl. All rights reserved.
//  散列表

import Foundation

let table = HashTable<String, Int>()
print("============哈希表插入数据==============")
table["沈阳市"] = 2210
table["康平县"] = 2210
table["辽中县"] = 2210
table["新民市"] = 2210
table["大连市"] = 2220
table["普兰店市"] = 2222
table["庄河市"] = 2223

table["瓦房店市"] = 2224
table["长海县"] = 2225
table["鞍山市"] = 2230
table["台安县"] = 2231

table.print();
print("当前哈希表的容量为：\(table.capacity)")
print("\n============哈希表扩容==============")
table["黑山县"] = 2274
table["义县"] = 2275
table["葫芦岛市"] = 2276
table["兴城市"] = 2277
table["营口市"] = 2280

table.print()
print("当前哈希表的容量为：\(table.capacity)")

print("\n============哈希表更新数据==============")
table["营口市"] = 33333
table["兴城市"] = 44444
table["义县"] = 55555
table["葫芦岛市"] = 66666
table.print()

print("\n============哈希表删除四个元素数据==============")
table["瓦房店市"] = nil
table["新民市"] = nil
table["鞍山市"] = nil
table["台安县"] = nil
table.print()
