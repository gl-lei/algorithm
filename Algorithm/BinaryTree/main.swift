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

print("\n============遍历二叉树==============")
bt.printTreeByPreOrder(.preOrder)
bt.printTreeByPreOrder(.inOrder)
bt.printTreeByPreOrder(.postOrder)
bt.printTreeByPreOrder(.levelOrder)

print("\n============二叉树的高度==============")
bt.printTreeHeight()
