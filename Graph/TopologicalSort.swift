//
//  TopologicalSort.swift
//  Graph
//
//  Created by ggl on 2020/6/21.
//  Copyright © 2020 ggl. All rights reserved.
//  拓扑排序Kahn算法和DFS算法

import Foundation

/// 拓扑排序（基于邻接表）
/// 拓扑排序是对有向图的顶点排成一个线性序列，可以用来判断图是否有环
/// 拓扑排序的序列不是唯一的，它反映了顶点之间先后关系（有向图无环图）
/// 拓扑排序的实际应用：学习课程有先修和后修，可以根据排序结果来安排课程的学习
/// 参考链接：https://blog.csdn.net/qinzhaokun/article/details/48541117


/*
 摘一段维基百科上关于Kahn算法的伪码描述：

 L← Empty list that will contain the sorted elements
 S ← Set of all nodes with no incoming edges
 while S is non-empty do
     remove a node n from S
     insert n into L
     foreach node m with an edge e from nto m do
         remove edge e from thegraph
         ifm has no other incoming edges then
             insert m into S
 if graph has edges then
     return error (graph has at least onecycle)
 else
     return L (a topologically sortedorder)
 **/

/// Kahn算法
/// 时间复杂度 O(V+E)(V表示顶点个数，E表示边的个数)，每个顶点被访问了一次，每个边也被访问了一次
///
/// - Parameter directedGraph: 有向无环图
/// - Returns: 拓扑序列，如果有环则返回nil
func kahnTopologicalSort<T>(directedGraph: ListGraph<T>) -> [T]? {
    guard directedGraph.count != 0 else {
        return nil
    }
    // 存储所有顶点的入度
    var indegressArr = [Int](repeating: 0, count: directedGraph.count)
    // 存储入度为0的顶点下标
    var zeroIndegreeQueue = [Int]()
    // 存储顶点结果集
    var result = [T]()
    // 边的数量，最后用来判断是否有环
    var edges: Int = 0
    
    
    // 遍历顶点数组
    for vertex in directedGraph.vertexArr {
        var node = vertex.next
        while node != nil {
            // 对应顶点入度加一，边加一
            indegressArr[node!.index] += 1
            edges += 1
            node = node!.next
        }
    }
    
    // 遍历入度数组，将入度为0的顶点下标加入到zeroIndegreeArr中
    for (i, indegree) in indegressArr.enumerated() {
        if indegree == 0 {
            zeroIndegreeQueue.append(i)
        }
    }
    
    while !zeroIndegreeQueue.isEmpty {
        // 出队列，将顶点加入到结果集中
        let index = zeroIndegreeQueue.remove(at: 0)
        let vertex = directedGraph.vertexArr[index]
        result.append(vertex.value)
        
        // 将顶点所指向的顶点的入度减一，边也减一
        var node = vertex.next
        while node != nil {
            let w = node!.index
            indegressArr[w] -= 1
            edges -= 1
            
            // 判断是否入度为0
            if indegressArr[w] == 0 {
                zeroIndegreeQueue.append(w)
            }
            node = node!.next
        }
    }
    
    // 图中还有边，表示有环路
    if edges != 0 {
        return nil
    }
    
    return result
}


/*
同样摘录一段维基百科上的伪码：
L ← Empty list that will contain the sorted nodes
S ← Set of all nodes with no outgoing edges
for each node n in S do
    visit(n)
function visit(node n)
    if n has not been visited yet then
        mark n as visited
        for each node m with an edgefrom m to ndo
            visit(m)
        add n to L
 这个算法的实现非常简单，但是要理解的话就相对复杂一点。
 关键在于为什么在visit方法的最后将该顶点添加到一个集合中，就能保证这个集合就是拓扑排序的结果呢？
 因为添加顶点到集合中的时机是在dfs方法即将退出之时，而dfs方法本身是个递归方法，只要当前顶点还存在边指向其它任何顶点，它就会递归调用dfs方法，而不会退出。
 因此，退出dfs方法，意味着当前顶点没有指向其它顶点的边了，即当前顶点是一条路径上的最后一个顶点。
**/

// 是否有环
var circle = false
// 存储一条路径上面的顶点，用来检测是否有环数组，在一条路径中出现两次就表示有环
var checkCircleArr = [Int]()

/// 基于DFS的拓扑排序
/// 使用邻接表，时间复杂度 O(V+E)，每个顶点被访问两次，每条边被访问一次
///
/// - Parameter directedGraph: 有向无环图
/// - Returns: 拓扑序列，如果有环则返回nil
func topologicalSortBasedDfs<T>(directedGraph: ListGraph<T>) -> [T]? {
    guard directedGraph.count != 0 else {
        return nil
    }
    // 逆邻接表
    var reversedVertexArr = [ListNode<T>]()
    // 出度为0的顶点下标数组
    var zeroOutdegreeArr = [Int]()
    // 记录顶点是否已访问数组
    var visited = [Bool](repeating: false, count: directedGraph.count)
    // 结果数组
    var result = [T]()
    
    // 构造逆邻接表
    for (i, vertex) in directedGraph.vertexArr.enumerated() {
        let node = ListNode<T>(value: vertex.value, index: i)
        reversedVertexArr.append(node)
    }
    for (i, vertex) in directedGraph.vertexArr.enumerated() {
        // 是否指向其他顶点
        var flag = false
        var node = vertex.next
        while node != nil {
            let index = node!.index
            let p = ListNode<T>(value: vertex.value, next: reversedVertexArr[index].next, index: i)
            reversedVertexArr[index].next = p
            node = node?.next
            flag = true
        }
        
        // 如果不指向其他顶点，则加入到zeroOutdegreeArr数组
        if !flag {
            zeroOutdegreeArr.append(i)
        }
    }
    
    // 递归寻找路径
    for index in zeroOutdegreeArr {
        recurVisit(reversedVertexArr: &reversedVertexArr, result: &result, visited:&visited, nodeIndex: index)
        // 清除一条路径的记录
        checkCircleArr.removeAll()
    }
    
    // 如果有环
    if circle {
        return nil
    }
    
    return result
}

/// 递归遍历，直到一条路径的最后一个顶点
/// - Parameters:
///   - reversedVertexArr: 逆邻接表
///   - result: 结果数组
///   - visited: 记录顶点访问的数组
///   - nodeIndex: 当前访问顶点下标
private func recurVisit<T>(reversedVertexArr: inout [ListNode<T>], result: inout [T], visited: inout [Bool], nodeIndex: Int) {
    // 图有环
    if circle {
        return
    }
    
    // 判断顶点是否被访问过
    if !visited[nodeIndex] {
        visited[nodeIndex] = true
        checkCircleArr.append(nodeIndex)
        
        // 递归循环最后一个顶点，前面的所有顶点入栈后，然后自己才入栈
        var node = reversedVertexArr[nodeIndex].next
        while node != nil {
            let index = node!.index
            recurVisit(reversedVertexArr: &reversedVertexArr, result: &result, visited: &visited, nodeIndex: index)
            node = node?.next
            
            // 检测到有环
            if circle {
                return
            }
        }
        result.append(reversedVertexArr[nodeIndex].value)
    } else if checkCircleArr.contains(nodeIndex) {
        // 在一条路径中被访问两次，表示有环
        circle = true
        checkCircleArr.append(nodeIndex)
        // print("图中检测到环：\(checkCircleArr)")
    }
}
