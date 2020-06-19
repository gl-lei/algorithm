//
//  main.swift
//  Graph
//
//  Created by ggl on 2020/6/17.
//  Copyright © 2020 ggl. All rights reserved.
//

import Foundation

print("============图==============")
print("============邻接矩阵==============")
/**
 无向图
 A ---(5)--- C ---(1)--- E
 |         / |           |
 |       /   |           |
 (1)   /(6)  |(7)        |(8)
 |   /       |           |
 | /         |           |
 B ---(3)--- D ---(4)--- F
 */
// 无向图邻接矩阵
let udMGraph = MatrixGraph<String>(type: .Undirected)
udMGraph.addVertex("A").addVertex("B").addVertex("C")
udMGraph.addVertex("D").addVertex("E").addVertex("F")
udMGraph.addEdge(from: "A", to: "B", weighted: 1)
udMGraph.addEdge(from: "A", to: "C", weighted: 5)
udMGraph.addEdge(from: "B", to: "C", weighted: 6)
udMGraph.addEdge(from: "B", to: "D", weighted: 3)
udMGraph.addEdge(from: "C", to: "D", weighted: 7)
udMGraph.addEdge(from: "C", to: "E", weighted: 1)
udMGraph.addEdge(from: "D", to: "F", weighted: 4)
udMGraph.addEdge(from: "E", to: "F", weighted: 8)
udMGraph.print()
print("")

/**
 有向图(2和4相互指向，5指向3)
 1 ------> 2 -----> 3
 ^      ~/~|      ~/~
 |     /   |     /
 |    /    |   /
 | ~/~     ⌵ /
 4 <------ 5
 */
// 有向图的邻接矩阵
let dMGraph = MatrixGraph<Int>(type: .Directed)
dMGraph.addVertex(1).addVertex(2).addVertex(3)
dMGraph.addVertex(4).addVertex(5)
dMGraph.addEdge(from: 1, to: 2)
dMGraph.addEdge(from: 2, to: 3)
dMGraph.addEdge(from: 2, to: 4)
dMGraph.addEdge(from: 2, to: 5)
dMGraph.addEdge(from: 4, to: 1)
dMGraph.addEdge(from: 4, to: 2)
dMGraph.addEdge(from: 5, to: 3)
dMGraph.addEdge(from: 5, to: 4)
dMGraph.print()

print("\n\n============邻接表==============")
/**
无向图
A ---(5)--- C ---(1)--- E
|         / |           |
|       /   |           |
(1)   /(6)  |(7)        |(8)
|   /       |           |
| /         |           |
B ---(3)--- D ---(4)--- F
*/
// 无向图的邻接表
let udListGraph = ListGraph<String>(type: .Undirected)
udListGraph.addVertex("A").addVertex("B").addVertex("C")
udListGraph.addVertex("D").addVertex("E").addVertex("F")
udListGraph.addEdge(from: "A", to: "B", weighted: 1)
udListGraph.addEdge(from: "A", to: "C", weighted: 5)
udListGraph.addEdge(from: "B", to: "C", weighted: 6)
udListGraph.addEdge(from: "B", to: "D", weighted: 3)
udListGraph.addEdge(from: "C", to: "D", weighted: 7)
udListGraph.addEdge(from: "C", to: "E", weighted: 1)
udListGraph.addEdge(from: "D", to: "F", weighted: 4)
udListGraph.addEdge(from: "E", to: "F", weighted: 8)
udListGraph.print()
print("")

/**
有向图(2和4相互指向，5指向3)
1 ------> 2 -----> 3
^      ~/~|      ~/~
|     /   |     /
|    /    |   /
| ~/~     ⌵ /
4 <------ 5
*/
// 有向图的邻接表
let dListGraph = ListGraph<Int>(type: .Directed)
dListGraph.addVertex(1).addVertex(2).addVertex(3)
dListGraph.addVertex(4).addVertex(5)
dListGraph.addEdge(from: 1, to: 2)
dListGraph.addEdge(from: 2, to: 3)
dListGraph.addEdge(from: 2, to: 4)
dListGraph.addEdge(from: 2, to: 5)
dListGraph.addEdge(from: 4, to: 1)
dListGraph.addEdge(from: 4, to: 2)
dListGraph.addEdge(from: 5, to: 3)
dListGraph.addEdge(from: 5, to: 4)
dListGraph.print()

print("\n============邻接矩阵搜索==============")
udMGraph.bfs(from: "A", to: "F")
udMGraph.dfs(from: "A", to: "F")
dMGraph.bfs(from: 1, to: 5)
dMGraph.dfs(from: 1, to: 5)

print("\n============邻接表搜索==============")
udListGraph.bfs(from: "A", to: "F")
udListGraph.dfs(from: "A", to: "F")
dListGraph.bfs(from: 1, to: 5)
dListGraph.dfs(from: 1, to: 5)





