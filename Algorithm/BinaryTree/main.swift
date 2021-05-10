//
//  main.swift
//  BinaryTree
//
//  Created by ggl on 2020/6/4.
//  Copyright © 2020 ggl. All rights reserved.
//

import Foundation

print("============创建二叉树==============")
let bt = BinaryTree()
bt.createTree()
bt.print()

print("\n============递归遍历二叉树==============")
bt.printTreeByRecur(.preOrder)
bt.printTreeByRecur(.inOrder)
bt.printTreeByRecur(.postOrder)
print("\n============非递归遍历二叉树==============")
bt.printTreeByNoRecur(.preOrder)
bt.printTreeByNoRecur(.inOrder)
bt.printTreeByNoRecur(.postOrder)
print("\n============二叉树的层级遍历==============")
bt.printTreeByNoRecur(.levelOrder)
print("\n============二叉树的高度==============")
bt.printTreeHeight()
