//
//  BinaryTree.swift
//  BinaryTree
//
//  Created by ggl on 2020/6/4.
//  Copyright © 2020 ggl. All rights reserved.
//  二叉树

import Foundation

/// 树的结点结构
class Node {
    /// 左子结点
    var left: Node?
    
    /// 右子结点
    var right: Node?
    
    /// 结点数据
    var data: String
    
    init(left: Node? = nil, right: Node? = nil, data: String) {
        self.left = left
        self.right = right
        self.data = data
    }
}

/// 树的遍历方式
enum TreeOrderType {
    case preOrder       // 前序遍历
    case inOrder        // 中序遍历
    case postOrder      // 后续遍历
    case levelOrder     // 层级遍历
}

/// 二叉树结构
class BinaryTree {
    /// 根节点
    private(set) var root: Node?
    
    /// 用户从终端输入的字符串
    private(set) var values: [String]
    
    init() {
        root = Node(data: "")
        values = []
    }
    
    /// 创建二叉树
    func createTree() {
        Swift.print("创建二叉树，结束请输入#号，(例如：A B D # # E # # C F # # G # #):")
        // 从终端读取输入的数据
        guard let valueStr = readLine() else {
            fatalError("Bad Input")
        }
        values = valueStr.split(separator: " ").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        createNode(node: &root)
    }
    
    /// 打印树的高度
    func printTreeHeight() {
        // 两种方式，都可以
        let h = treeHeight(node: root)
        let h1 = treeHeightByLevelOrder(node: root)
        Swift.print("二叉树的高度是：\(h) \(h1)")
    }
    
    /// 遍历
    func printTreeByPreOrder(_ type: TreeOrderType) {
        switch type {
        case .preOrder:
            Swift.print("前序遍历：", terminator:"")
            preOrder(node: root)
        case .inOrder:
            Swift.print("中序遍历：", terminator:"")
            inOrder(node: root)
        case .postOrder:
            Swift.print("后序遍历：", terminator:"")
            postOrder(node: root)
        case .levelOrder:
            Swift.print("层级遍历：", terminator:"")
            levelOrder(node: root)
        }
        Swift.print("")
    }
    
    /// 遍历打印二叉树
    func print() {
        if root == nil {
            Swift.print("二叉树是一颗空树")
            return
        }
        
        var nodes = [Node?]()    // 结点队列
        var front = 0           // 队头
        var rear = 1            // 队尾
        var floor = 0           // 树的深度
        Swift.print("第\(floor+1)层：", terminator:"")
        
        nodes.append(root!)
        while !nodes.isEmpty {
            let node = nodes.remove(at: 0)
            Swift.print("\(node?.data ?? "#") ", terminator:"")
            front += 1
            
            // 加入子结点，不能同时为空
            if node?.left != nil || node?.right != nil {
                nodes.append(node?.left)
                nodes.append(node?.right)
            }
            
            if front == rear {
                Swift.print("")
                // 进入下一层
                front = 0
                rear = nodes.count
                floor += 1      // 层数+1
                
                if rear != 0 {
                    Swift.print("第\(floor+1)层：", terminator:"")
                }
            }
        }
    }
}

/// 递归相关的方法
extension BinaryTree {
    /// 递归创建结点
    /// - param node: 根节点
    fileprivate func createNode(node: UnsafeMutablePointer<Node?>) {
        if values.isEmpty {
            return
        }
        
        let valStr = values.remove(at: 0)
        if valStr == "#" {
            return
        }
        
        if node.pointee == nil {
            node.pointee = Node(data: valStr)
        }
        node.pointee?.data = valStr
        
        // 创建左子结点
        createNode(node: &node.pointee!.left)
        
        // 创建右子结点
        createNode(node: &node.pointee!.right)
    }
    
    /// 递归先序遍历
    fileprivate func preOrder(node: Node?) {
        if node == nil {
            return
        }
        Swift.print("\(node!.data) ", terminator:"")
        preOrder(node: node?.left)
        preOrder(node: node?.right)
    }
    
    /// 递归中序遍历
    fileprivate func inOrder(node: Node?) {
        if node == nil {
            return
        }
        inOrder(node: node?.left)
        Swift.print("\(node!.data) ", terminator:"")
        inOrder(node: node?.right)
    }
    
    /// 递归后序遍历
    fileprivate func postOrder(node: Node?) {
        if node == nil {
            return
        }
        postOrder(node: node?.left)
        postOrder(node: node?.right)
        Swift.print("\(node!.data) ", terminator:"")
    }
    
    /// 层级遍历
    fileprivate func levelOrder(node: Node?) {
        if node == nil {
            return
        }
        
        // 队列
        var nodes = [Node]()
        nodes.append(node!)
        while !nodes.isEmpty {
            let node = nodes.remove(at: 0)
            Swift.print("\(node.data) ", terminator:"")
            
            if node.left != nil {
                nodes.append(node.left!)
            }
            
            if node.right != nil {
                nodes.append(node.right!)
            }
        }
    }
    
    /// 求树的高度
    /// 利用递归法求解
    fileprivate func treeHeight(node: Node?) -> Int {
        if node == nil {
            return 0
        }
        let leftH = treeHeight(node: node?.left)
        let rightH = treeHeight(node: node?.right)
        return max(leftH, rightH) + 1
    }
    
    /// 求树的高度
    /// 通过层级遍历求解
    fileprivate func treeHeightByLevelOrder(node: Node?) -> Int {
        if node == nil {
            return 0
        }
        
        // 层级开始下标
        var front = 0
        // 层级结束下标
        var rear = 1
        // 高度
        var floor = 0
        
        // 层级遍历辅助队列
        var nodes = [Node]()
        nodes.append(node!)
        while !nodes.isEmpty {
            let node = nodes.remove(at: 0)
            front += 1
            
            // 加入左子结点
            if let leftNode = node.left {
                nodes.append(leftNode)
            }
            
            // 加入右子结点
            if let rightNode = node.right {
                nodes.append(rightNode)
            }
            
            if front == rear {
                // 表示遍历了一层
                front = 0
                rear = nodes.count
                floor += 1
            }
        }
        return floor
    }
}





