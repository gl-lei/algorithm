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

print("\n============Kruskal(克鲁斯卡尔)最小生成树算法==============")
// 图例地址：https://www.cnblogs.com/skywang12345/p/3711496.html
let kruskalUDGraph = ListGraph<String>(type: .Undirected)
kruskalUDGraph.addVertex("A").addVertex("B").addVertex("C")
kruskalUDGraph.addVertex("D").addVertex("E").addVertex("F")
kruskalUDGraph.addVertex("G")
kruskalUDGraph.addEdge(from: "A", to: "B", weighted: 12)
kruskalUDGraph.addEdge(from: "A", to: "F", weighted: 16)
kruskalUDGraph.addEdge(from: "A", to: "G", weighted: 14)
kruskalUDGraph.addEdge(from: "B", to: "C", weighted: 10)
kruskalUDGraph.addEdge(from: "B", to: "F", weighted: 7)
kruskalUDGraph.addEdge(from: "C", to: "D", weighted: 3)
kruskalUDGraph.addEdge(from: "C", to: "E", weighted: 5)
kruskalUDGraph.addEdge(from: "C", to: "F", weighted: 6)
kruskalUDGraph.addEdge(from: "D", to: "E", weighted: 4)
kruskalUDGraph.addEdge(from: "E", to: "F", weighted: 2)
kruskalUDGraph.addEdge(from: "E", to: "G", weighted: 8)
kruskalUDGraph.addEdge(from: "F", to: "G", weighted: 9)
kruskalUDGraph.print()

print("")
kruskalUDGraph.kruskal()

print("\n============Prim(普里姆)最小生成树算法==============")
// 图例地址：https://www.cnblogs.com/skywang12345/p/3711496.html
let primUDGraph = ListGraph<String>(type: .Undirected)
primUDGraph.addVertex("A").addVertex("B").addVertex("C")
primUDGraph.addVertex("D").addVertex("E").addVertex("F")
primUDGraph.addVertex("G")
primUDGraph.addEdge(from: "A", to: "B", weighted: 12)
primUDGraph.addEdge(from: "A", to: "F", weighted: 16)
primUDGraph.addEdge(from: "A", to: "G", weighted: 14)
primUDGraph.addEdge(from: "B", to: "C", weighted: 10)
primUDGraph.addEdge(from: "B", to: "F", weighted: 7)
primUDGraph.addEdge(from: "C", to: "D", weighted: 3)
primUDGraph.addEdge(from: "C", to: "E", weighted: 5)
primUDGraph.addEdge(from: "C", to: "F", weighted: 6)
primUDGraph.addEdge(from: "D", to: "E", weighted: 4)
primUDGraph.addEdge(from: "E", to: "F", weighted: 2)
primUDGraph.addEdge(from: "E", to: "G", weighted: 8)
primUDGraph.addEdge(from: "F", to: "G", weighted: 9)
primUDGraph.print()

print("")
primUDGraph.prim(start: 0)

print("\n============Dijkstra(迪杰斯特拉)算法==============")
/**
 有向图Dijkstra算法演示(V4指向V6，V5指向V6)
 示例链接：https://blog.csdn.net/qq_35644234/article/details/60870719
 V2 ---(5)----> V3 <---(10)--- V1 --(100)--> V6
                |              |         ♐︎  ♐︎
                |              |      ♐︎   ♐︎
               (50)           (30)     (60)
                |     (10)♐︎    |      ♐︎
                ⌵  ♐︎           ⌵    ♐︎
                V4 <---(20)--- V5
 */
let dListGraph1 = ListGraph<String>(type: .Directed)
dListGraph1.addVertex("V1").addVertex("V2").addVertex("V3")
dListGraph1.addVertex("V4").addVertex("V5").addVertex("V6")
dListGraph1.addEdge(from: "V1", to: "V3", weighted: 10)
dListGraph1.addEdge(from: "V1", to: "V5", weighted: 30)
dListGraph1.addEdge(from: "V1", to: "V6", weighted: 100)
dListGraph1.addEdge(from: "V2", to: "V3", weighted: 5)
dListGraph1.addEdge(from: "V3", to: "V4", weighted: 50)
dListGraph1.addEdge(from: "V4", to: "V6", weighted: 10)
dListGraph1.addEdge(from: "V5", to: "V4", weighted: 20)
dListGraph1.addEdge(from: "V5", to: "V6", weighted: 60)
dListGraph1.print()

print("")
dListGraph1.dijkstra(from: "V1")

/**
 无向图Dijkstra算法演示
 示例链接：http://wangkuiwu.github.io/2013/04/14/dijkstra-java/
 */
let udListGraph1 = ListGraph<String>(type: .Undirected)
udListGraph1.addVertex("A").addVertex("B").addVertex("C").addVertex("D")
udListGraph1.addVertex("E").addVertex("F").addVertex("G")
udListGraph1.addEdge(from: "A", to: "B", weighted: 12)
udListGraph1.addEdge(from: "A", to: "F", weighted: 16)
udListGraph1.addEdge(from: "A", to: "G", weighted: 14)
udListGraph1.addEdge(from: "B", to: "C", weighted: 10)
udListGraph1.addEdge(from: "B", to: "F", weighted: 7)
udListGraph1.addEdge(from: "G", to: "F", weighted: 9)
udListGraph1.addEdge(from: "G", to: "E", weighted: 8)
udListGraph1.addEdge(from: "F", to: "C", weighted: 6)
udListGraph1.addEdge(from: "F", to: "E", weighted: 2)
udListGraph1.addEdge(from: "C", to: "D", weighted: 3)
udListGraph1.addEdge(from: "C", to: "E", weighted: 5)
udListGraph1.addEdge(from: "E", to: "D", weighted: 4)
udListGraph1.print()

print("")
udListGraph1.dijkstra(from: "D")

print("\n============拓扑排序Kahn算法==============")
// 示例图参考： https://blog.csdn.net/qinzhaokun/article/details/48541117
let kahnGraph = ListGraph<Int>(type: .Directed)
kahnGraph.addVertex(0).addVertex(1).addVertex(2).addVertex(3).addVertex(4)
kahnGraph.addVertex(5).addVertex(6).addVertex(7).addVertex(8).addVertex(9)
kahnGraph.addVertex(10).addVertex(11).addVertex(12)
kahnGraph.addEdge(from: 0, to: 1)
kahnGraph.addEdge(from: 0, to: 5)
kahnGraph.addEdge(from: 0, to: 6)
kahnGraph.addEdge(from: 2, to: 0)
kahnGraph.addEdge(from: 2, to: 3)
kahnGraph.addEdge(from: 3, to: 5)
kahnGraph.addEdge(from: 5, to: 4)
kahnGraph.addEdge(from: 6, to: 4)
kahnGraph.addEdge(from: 6, to: 9)
kahnGraph.addEdge(from: 7, to: 6)
kahnGraph.addEdge(from: 8, to: 7)
kahnGraph.addEdge(from: 9, to: 10)
kahnGraph.addEdge(from: 9, to: 11)
kahnGraph.addEdge(from: 9, to: 12)
kahnGraph.addEdge(from: 11, to: 12)
// 加上下面这行代码是有环图
//kahnGraph.addEdge(from: 12, to: 9)
kahnGraph.print()

if let result = kahnTopologicalSort(directedGraph: kahnGraph) {
    print("拓扑排序kahn算法结果：\(result)")
} else {
    print("拓扑排序kahn算法结果：图中有环")
}

if let result = topologicalSortBasedDfs(directedGraph: kahnGraph) {
    print("基于DFS拓扑排序结果：\(result)")
} else {
    print("基于DFS拓扑排序结果：图中有环")
}
