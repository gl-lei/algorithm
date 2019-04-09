//
//  Browser.swift
//  Stack
//
//  Created by ggl on 2019/4/9.
//  Copyright © 2019年 ggl. All rights reserved.
//

import Foundation

class Browser {
    var curStack: ArrayStack<String>
    var forwardStack: ArrayStack<String>
    var curPage: String {
        if let page = curStack.pop() {
            curStack.push(page)
            return "当前页面为：\(page)"
        } else {
            return "目前没有打开任何页面"
        }
    }
    
    init() {
        curStack = ArrayStack<String>()
        forwardStack = ArrayStack<String>()
    }
    
    /// 打开新页面
    ///
    /// - Parameter page: 新页面
    func openNewPage(_ page: String) {
        print("打开新页面：\(page)")
        curStack.push(page)
    }
    
    /// 页面前进
    ///
    /// - Returns: 前进是否成功
    @discardableResult
    func goForward() -> Bool {
        if let page = forwardStack.pop() {
            print("前进到页面：\(page)")
            curStack.push(page)
            return true
        } else {
            print("暂无页面可前进")
            return false
        }
    }
    
    /// 页面后退
    ///
    /// - Returns: 后退是否成功
    @discardableResult
    func goBackward() -> Bool {
        if curStack.count <= 1 {
            print("暂无页面可后退")
            return false
        }
        
        let page = curStack.pop()!
        forwardStack.push(page)
        print("页面后退，\(curPage)")
        return true
    }
    
}
