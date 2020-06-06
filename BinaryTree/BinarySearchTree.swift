//
//  BinarySearchTree.swift
//  BinaryTree
//
//  Created by ggl on 2020/6/6.
//  Copyright © 2020 ggl. All rights reserved.
//  二叉搜索树

import Foundation

/// 树的结点结构
class SNode {
    /// 左子结点
    var left: SNode?
    
    /// 右子结点
    var right: SNode?
    
    /// 结点数据
    var data: Int
    
    init(left: SNode? = nil, right: SNode? = nil, data: Int) {
        self.left = left
        self.right = right
        self.data = data
    }
}

/// 二叉搜索树
/// 左子树的每个结点的值，都要小于这个结点的值；右子树结点的值都大于这个结点的值
/// 中序遍历二叉搜索树，可以输出有序的数据序列，时间复杂度是O(n)
/// 支持重复数据的二叉搜索树右两种解决方法：
/// 1.通过链表和支持动态扩容的数组等结构，把值相同的数据都存储在同一个结点上
/// 2.在查找插入过程中，如果碰到一个结点的值与要插入的值相同，就把这个结点数据放到这个结点的右子树
/// 查找数据的时候，遇到值相同的结点，并不停止查找操作，而是继续在右子树中查找，直到遇到叶子结点，才停止
///
/// 不管操作是插入、删除还是查找，时间复杂度其实都跟树的高度成正比，也就是O(Height)
/// 平衡二叉查找树高度接近logn，插入、删除、查找操作的时间复杂度也比较稳定，是O(logn)
class BinarySearchTree {
    /// 根结点
    private(set) var root: SNode?
    
    /// 查找结点
    func find(data: Int) -> SNode? {
        var p = root
        while p != nil {
            if data < p!.data {
                p = p?.left
            } else if data > p!.data {
                p = p?.right
            } else {
                return p
            }
            
        }
        return nil
    }
    
    /// 插入结点
    func insert(data: Int) {
        if root == nil {
            root = SNode(data: data)
            return
        }
        
        var p = root
        while p != nil {
            if data > p!.data {
                // 数据大于 p.data 查找右子树
                if p?.right == nil {
                    p?.right = SNode(data: data)
                    return;
                }
                p = p?.right
            } else {
                // 数据小于 p.data 查找左子树
                if p?.left == nil {
                    p?.left = SNode(data: data)
                    return;
                }
                p = p?.left
            }
        }
    }
    
    /// 删除结点
    func delete(data: Int) {
        var p: SNode? = root    // p指向要删除的结点，初始化指向根节点
        var pp: SNode? = nil    // pp记录的是p的父节点
        
        // 搜索找到要删除的结点
        while p != nil && p!.data != data {
            pp = p
            if data > p!.data {
                p = p?.right
            } else {
                p = p?.left
            }
        }
        
        if p == nil {
            // 没有找到要删除的数据结点
            return
        }
        
        // 要删除的结点有两个子结点
        if p?.left != nil && p?.right != nil {
            // 查找右子树中的最小值
            var minPP = p           // minPP是minP的父结点
            var minP = p?.right
            while minP?.left != nil {
                minPP = minP
                minP = minP?.left
            }
            p!.data = minP!.data    // 将minP的数据替换到p中
            p = minP
            pp = minPP              // 下面就编程删除minP了
        }
        
        // 要删除的结点是叶子结点或者仅有一个子节点
        // 获取到要删除结点的子节点
        var child: SNode?
        if p?.left != nil {
            child = p?.left
        } else if p?.right != nil {
            child = p?.right
        } else {
            child = nil
        }
        
        // 定位要删除的是根节点、左子结点或右子结点
        if pp == nil {
            // 要删除的是根节点
            root = child
        } else if pp?.left != nil && pp!.left!.data == p!.data {
            pp?.left = child
        } else {
            pp?.right = child
        }
    }
}
