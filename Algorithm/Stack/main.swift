//
//  main.swift
//  Stack
//
//  Created by ggl on 2019/4/8.
//  Copyright © 2019年 ggl. All rights reserved.
//

import Foundation

//MARK: - 顺序栈
print("===============顺序栈=================")
var arrayStack = ArrayStack<Int>()
for i in 1...10 {
    arrayStack.push(i)
}
arrayStack.print()
arrayStack.pop()
arrayStack.pop()
arrayStack.print()

//MARK: - 链式栈
print("===============链式栈=================")
var linkedListStack = LinkedListStack<String>()
linkedListStack.push("cat")
linkedListStack.push("dog")
linkedListStack.push("lion")
linkedListStack.push("tiger")
linkedListStack.print()

linkedListStack.pop()
linkedListStack.pop()
linkedListStack.print()

//MARK: - 模拟浏览器前进与后退
print("===============模拟浏览器前进与后退=================")
let browser = Browser()
browser.openNewPage("http://www.baidu.com")
browser.openNewPage("http://www.google.com")
browser.openNewPage("http://swift.org")

browser.goForward()
browser.goForward()
browser.goBackward()
browser.goBackward()
print(browser.curPage)
browser.goForward()
print(browser.curPage)

//考虑一下使用UnsafeMutablePointer<String>来实现底层栈结构？目前还不会写
