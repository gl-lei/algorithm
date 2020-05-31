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

print("====================LRU 缓存算法=====================")
let lruHashTable = LRUBaseHashTable<String, Int>(capcity: 10)
lruHashTable["沈阳市"] = 2210
lruHashTable["康平县"] = 2210
lruHashTable["辽中县"] = 2210
lruHashTable.print()

print("======================删除头结点=======================")
lruHashTable["沈阳市"] = nil
lruHashTable.print()

print("======================删除尾结点=======================")
lruHashTable["康平县"] = nil
lruHashTable["辽中县"] = nil
lruHashTable.print()

lruHashTable["新民市"] = 2210
lruHashTable["大连市"] = 2220
lruHashTable["普兰店市"] = 2222
lruHashTable["庄河市"] = 2223

lruHashTable["瓦房店市"] = 2224
lruHashTable["长海县"] = 2225
lruHashTable["鞍山市"] = 2230
lruHashTable["台安县"] = 2231
print("访问庄河市: \(lruHashTable["庄河市"]!)")
print("访问长海县: \(lruHashTable["长海县"]!)")
print("删除新民市、庄河市、北京市")
lruHashTable.remove(for: "新民市")
lruHashTable.remove(for: "庄河市")
lruHashTable.remove(for: "北京市")

lruHashTable.print()
