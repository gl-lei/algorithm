//
//  BinaryTree.swift
//  BinaryTree
//
//  Created by ggl on 2020/6/4.
//  Copyright © 2020 ggl. All rights reserved.
//  二叉树

import Foundation

/// 树的遍历方式
enum TreeOrderType {
    case preOrder       // 前序遍历
    case inOrder        // 中序遍历
    case postOrder      // 后序遍历
    case levelOrder     // 层级遍历
}

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

extension Node: Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.data == rhs.data
    }
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
    
    /// 递归遍历
    func printTreeByRecur(_ orderType: TreeOrderType) {
        switch orderType {
        case .preOrder:
            Swift.print("递归前序遍历：", terminator:"")
            preOrder(node: root)
        case .inOrder:
            Swift.print("递归中序遍历：", terminator:"")
            inOrder(node: root)
        case .postOrder:
            Swift.print("递归后序遍历：", terminator:"")
            postOrder(node: root)
        case .levelOrder:
            Swift.print("层级遍历：", terminator:"")
            levelOrder(node: root)
        }
        Swift.print("")
    }
    
    /// 非递归遍历
    func printTreeByNoRecur(_ orderType: TreeOrderType) {
        switch orderType {
        case .preOrder:
            Swift.print("非递归前序遍历：", terminator: "")
            preOrderByNoRecur(node: root)
        case .inOrder:
            Swift.print("非递归中序遍历：", terminator: "")
            inOrderByNoRecur(node: root)
        case .postOrder:
            Swift.print("非递归后序遍历：", terminator: "")
            postOrderByNoRecur(node: root)
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
        
        var nodes = [Node]()    // 结点队列
        var front = 0           // 队头
        var rear = 1            // 队尾
        var floor = 0           // 树的深度
        Swift.print("第\(floor+1)层：", terminator:"")
        
        nodes.append(root!)
        while !nodes.isEmpty {
            let node = nodes.remove(at: 0)
            Swift.print("\(node.data) ", terminator:"")
            front += 1
            
            // 加入子结点，不能同时为空
            if node.left != nil {
                nodes.append(node.left!)
            }
            if node.right != nil {
                nodes.append(node.right!)
            }
            
            if front == rear {
                Swift.print("")
                // 进入下一层
                front = 0
                rear = nodes.count
                floor += 1      // 层数+1
                
                if (rear != 0) {
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
}

/// 非递归遍历
/// 二叉树的遍历所有的结点都会遍历两次，一次是入栈过程，一次是出栈过程；
/// 先序遍历：在根结点入栈的时候进行打印，先左后右；
/// 中序遍历：入栈过程不能打印，直到没有左子结点。出栈过程进行打印即可，先左后右；
/// 后序遍历：入栈过程不能打印，出栈过程打印，但出栈过程打印需要有条件，必须确保右子结点遍历完成：
/// 1. 当前结点的左子结点和右子结点不存在，出栈打印；
/// 2. 当前结点的前一个结点是左子结点，并且右子结点不存在，出栈打印；
/// 3. 当前结点的前一个结点是右子结点，出栈打印；（右子结点遍历完毕）
extension BinaryTree {
    /// 非递归先序遍历
    /// - Parameter node: 根结点
    fileprivate func preOrderByNoRecur(node: Node?) {
        if node == nil {
            return
        }
        // 结点栈结构
        var stackNodeArr = [Node]()
        
        // 将左子树结点入栈（把左子结点看作根结点）
        var node = node
        while node != nil {
            // 入栈前打印
            Swift.print(node!.data, terminator: " ")
            stackNodeArr.append(node!)
            node = node?.left
        }
        
        // 回溯，将栈中的结点输出
        while !stackNodeArr.isEmpty {
            let topNode = stackNodeArr.removeLast()
            var rightNode = topNode.right
            
            // 把 rightNode 看作根结点，重复上面的流程
            while rightNode != nil {
                // 入栈前打印
                Swift.print(rightNode!.data, terminator: " ")
                stackNodeArr.append(rightNode!)
                rightNode = rightNode?.left
            }
        }
    }
    
    /// 非递归中序遍历
    fileprivate func inOrderByNoRecur(node: Node?) {
        if node == nil {
            return
        }
        // 结点栈结构
        var stackNodeArr = [Node]()
        
        // 左子树结点入栈（根结点）
        var node = node
        while node != nil {
            stackNodeArr.append(node!)
            node = node?.left
        }
        
        // 回溯遍历栈
        while !stackNodeArr.isEmpty {
            // 取出结点打印
            let topNode = stackNodeArr.removeLast()
            Swift.print(topNode.data, terminator: " ")
            
            // 取出右结点
            var rightNode = topNode.right
            while rightNode != nil {
                stackNodeArr.append(rightNode!)
                rightNode = rightNode?.left
            }
        }
    }
    
    /// 后续遍历
    fileprivate func postOrderByNoRecur(node: Node?) {
        if node == nil {
            return
        }
        // 结点栈结构
        var stackNodeArr = [Node]()
        
        // 当前结点的前一个结点
        var lastNode: Node? = nil
        
        // 左子树结点入栈
        var node = node
        while node != nil {
            stackNodeArr.append(node!)
            node = node?.left
        }
        
        // 回溯栈结构
        while !stackNodeArr.isEmpty {
            let topNode = stackNodeArr.last!
            // 出栈的条件改变了，三种情况需要进行出栈操作：
            // 1.当前结点的前一个结点是左子结点，并且当前结点的右子结点为空，可以进行出栈
            // 2.当前结点的前一个结点是右子结点，说明右子树遍历完毕，可以进行出栈
            // 2.当前结点的左子结点和右子结点不存在，也就是当前结点为叶子结点，也可以进行出栈
            if topNode.left == lastNode && topNode.right == nil ||
                topNode.right == lastNode ||
                topNode.left == nil && topNode.right == nil {
                // 出栈
                Swift.print(topNode.data, terminator: " ")
                stackNodeArr.removeLast()
                lastNode = topNode
            } else {
                // 将右子树加入
                var rightNode = topNode.right
                while rightNode != nil {
                    stackNodeArr.append(rightNode!)
                    rightNode = rightNode?.left
                }
            }
        }
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





