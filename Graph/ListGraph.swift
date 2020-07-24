//
//  ListGraph.swift
//  Graph
//
//  Created by ggl on 2020/6/18.
//  Copyright © 2020 ggl. All rights reserved.
//  邻接表(链表)

import Foundation

/// 邻接表类型
enum ListGraphType {
    // 无向的
    case Undirected
    
    // 有向的
    case Directed
}

/// 邻接表结点
class ListNode<T: Equatable & CustomStringConvertible> {
    /// 存储的数据
    var value: T
    
    /// 下一个结点
    var next: ListNode?
    
    /// 权重
    var weighted: Int
    
    /// 在顶点数组中所处的下标
    var index: Int
    
    /// 最短搜索路径中使用，表示从所求起始顶点到此顶点的最短距离
    var distance: Int
    
    init(value: T, next: ListNode? = nil, weighted: Int = 0, index: Int = -1, distance: Int = Int.max) {
        self.value = value
        self.next = next
        self.weighted = weighted
        self.index = index
        self.distance = distance
    }
}

/// 邻接表边结构
class ListEdge<T: Equatable & CustomStringConvertible> {
    /// 边的起点
    var start: T
    
    /// 边的终点
    var end: T
    
    /// 边的起点所对应的定点下标
    var startIndex: Int
    
    /// 边的终点所对应的定点下标
    var endIndex: Int
    
    /// 边的权重
    var weight: Int
    
    init(start: T, end: T, startIndex: Int, endIndex: Int, weight: Int = 0) {
        self.start = start
        self.end = end
        self.startIndex = startIndex
        self.endIndex = endIndex
        self.weight = weight
    }
}

/// 邻接表
class ListGraph<T: Equatable & CustomStringConvertible> {
    /// 存储的元素个数
    private(set) var count: Int
    
    /// 顶点数组，用来存储顶点
    private(set) var vertexArr: [ListNode<T>]
    
    /// 邻接表类型
    private let type: ListGraphType
    
    /// 深度优先搜索辅助变量
    private var found: Bool = false
    
    /// 初始化邻接表
    /// - Parameter type: 邻接表类型
    init(type: ListGraphType) {
        self.type = type
        count = 0
        vertexArr = []
    }
    
    /// 添加顶点
    /// - Parameter vertex: 顶点
    @discardableResult
    func addVertex(_ vertex: T) -> Self {
        count += 1
        vertexArr.append(ListNode(value: vertex, index: count-1))
        return self
    }
    
    /// 查找顶点对应的下标
    /// - Parameter vertex: 顶点
    private func indexOf(_ vertex: T) -> Int? {
        return vertexArr.firstIndex { $0.value == vertex }
    }
    
    /// 添加两个顶点之间的边关系
    /// - Parameters:
    ///   - form: 从哪个顶点出发
    ///   - to: 到哪个顶点
    ///   - weighted: 权重
    @discardableResult
    func addEdge(from: T, to: T, weighted: Int = 0) -> Bool {
        guard let f = indexOf(from), let t = indexOf(to), f != t else {
            return false
        }
        switch type {
        case .Directed:
            // 有向图
            let toNode = ListNode(value: to, next: vertexArr[f].next, weighted: weighted, index: t)
            vertexArr[f].next = toNode
        case .Undirected:
            // 无向图
            let toNode = ListNode(value: to, next: vertexArr[f].next, weighted: weighted, index: t)
            let fromNode = ListNode(value: from, next: vertexArr[t].next, weighted: weighted, index: f)
            vertexArr[f].next = toNode
            vertexArr[t].next = fromNode
        }
        return true
    }
    
    /// 打印图
    func print() {
        Swift.print("\(type == .Directed ? "邻接表有向图" : "邻接表无向图") =》")
        for i in 0..<count {
            Swift.print("\(vertexArr[i].value): ", terminator: "")
            var p = vertexArr[i].next
            // 没有指向的顶点
            if p == nil {
                Swift.print("无")
                continue
            }
            
            // 遍历顶点
            while p != nil {
                Swift.print("-> (权重:\(p!.weighted))\(p!.value)", terminator: " ")
                p = p?.next
            }
            Swift.print("")
        }
    }
}

// MARK: - 图的搜索算法：BFS和DFS
extension ListGraph {
    /// 广度优先搜索，打印搜索路径
    /// 时间复杂度为O(V+E)，V表示顶点个数，E表示边的个数。对于连通图来说，因为边的个数大于等于V-1
    /// 所以，广度优先搜索的时间复杂度简写为O(E)
    /// 空间复杂度消耗再几个辅助变量 visited 数组、queue 队列、prev数组上，这三个存储空间大小都不会超过顶点个数
    /// 所依，空间复杂度是O(V)
    /// - Parameters:
    ///   - from: 从哪个顶点
    ///   - to: 到哪个顶点
    func bfs(from: T, to: T) {
        guard let f = indexOf(from), let t = indexOf(to), f != t else {
            return
        }
        // 顶点是否已访问
        var visited = [Bool](repeating: false, count: count)
        // 搜索路径，-1代表没有上一个结点
        var prev = [Int](repeating: -1, count: count)
        // 层序遍历队列
        var queue = [Int]()
        
        // 将起始点入队列，进行层序遍历
        queue.append(f)
        visited[f] = true
        while !queue.isEmpty {
            let index = queue.remove(at: 0)
            var node = vertexArr[index].next
            while node != nil {
                // 结点的索引
                let i = node!.index
                
                // 如果结点没被访问过，记录路径
                if !visited[i] {
                    prev[i] = index
                    
                    // 检测是否访问到目的顶点
                    if i == t {
                        Swift.print("从顶点\(from)到顶点\(to)的访问路径(广度优先搜索)：", terminator: "")
                        print(prev: &prev, from: f, to: t)
                        Swift.print("")
                        return
                    }
                }
                // 继续遍历
                visited[i] = true
                queue.append(i)
                node = node?.next
            }
        }
        
    }
    
    /// 深度优先搜索
    /// 深度优先搜索采用回溯思想，这种思想解决问题的过程，非常适合用递归来实现
    /// 深度优先搜索每条边最多会被访问两次，一次是遍历，一次是回退，所以，
    /// 时间复杂度为O(E)，E表示边的个数
    /// 消耗的内存空间主要是 visited、prev 数组和递归调用栈。visited、prev数组的大小跟顶点的个数 V 成正比，
    /// 递归调用栈的最大深度不会超过顶点的个数，所以，总的空间复杂度就是 O(V)
    /// - Parameters:
    ///   - from: 起始顶点
    ///   - to: 目的顶点
    func dfs(from: T, to: T) {
        guard let f = indexOf(from), let t = indexOf(to), f != t else {
            return
        }
        // 顶点是否已访问
        var visited = [Bool](repeating: false, count: count)
        //搜索路径
        var prev = [Int](repeating: -1, count: count)
        // 递归查找
        recurDfs(from: f, to: t, visited: &visited, prev: &prev)
        
        // 如果找到了路径结点
        if found {
            Swift.print("从顶点\(from)到顶点\(to)的访问路径(深度优先搜索)：", terminator: "")
            print(prev: &prev, from: f, to: t)
            Swift.print("")
            found = false
        }
    }
    
    /// 深度优先搜索递归
    /// - Parameters:
    ///   - from: 起始顶点索引
    ///   - to: 目的顶点索引
    ///   - visited: 记录访问的顶点数组
    ///   - prev: 记录访问路径的数组
    private func recurDfs(from: Int, to: Int, visited: inout [Bool], prev: inout [Int]) {
        if found {
            return
        }
        // 设置顶点已被访问
        visited[from] = true
        if from == to {
            found = true
            return
        }
        var node = vertexArr[from].next
        while node != nil {
            let nextIndex = node!.index
            
            // 如果结点没有被访问的话
            if !visited[nextIndex] {
                prev[nextIndex] = from
                // 递归
                recurDfs(from: nextIndex, to: to, visited: &visited, prev: &prev)
            }
            node = node?.next
        }
    }
    
    /// 递归打印指定起始顶点到目的顶点的搜索路径
    /// - Parameters:
    ///   - prev: 搜索路径索引数组
    ///   - from: 起始顶点索引
    ///   - to: 目标顶点索引
    func print(prev: inout [Int], from: Int, to: Int) {
        if prev[to] != -1 && to != from {
            print(prev: &prev, from: from, to: prev[to])
        }
        Swift.print("\(vertexArr[to].value) ", terminator: "")
    }
}

// MARK: - 最小生成树算法
extension ListGraph {
    /// 克鲁斯卡尔（Kruskal）最小生成树
    /// 基本思想：按照权值从小到大的顺序选择n-1条边，并保证这n-1条边不构成回路
    /// 需要解决两个问题：
    /// 1.对图的所有边按照权值大小进行排序
    /// 2.将边添加到最小生成树中时，怎么判断是否形成了回路
    /// 问题一采用排序算法解决；
    /// 问题二记录顶点在最小生成树中的终点，顶底的终点是"是在最小生成树中与它连通的最大顶点"
    func kruskal() {
        // 保存"已有最小生成树"中每个顶点在该最小s树种的终点
        var vends = [Int](repeating: 0, count: count)
        // 结果数组，保存kruskal最小生成树的边
        var resultEdges = [ListEdge<T>]()
        
        // 获取排序好的图的所有的边
        let allEdges = getSortedGraphEdges()
        
        for i in 0..<allEdges.count {
            // 边的起始点在当前最小生成树中的终点
            let endM = getEndVertexIndex(vendes: &vends, from: allEdges[i].startIndex)
            // 边的终点在当前最小生成树种的终点
            let endN = getEndVertexIndex(vendes: &vends, from: allEdges[i].endIndex)
            
            // 如果不相等，则说明没有形成闭环
            if endM != endN {
                vends[endM] = endN
                resultEdges.append(allEdges[i])
            }
        }
        
        // 打印结果
        printKruskalMST(edges: resultEdges)
    }
    
    /// 获取排序好的边结构数组（按照权重从小到大）
    ///
    /// - Returns: 边结构数组
    private func getSortedGraphEdges() -> [ListEdge<T>] {
        // 边结构数组
        var edges = [ListEdge<T>]()
        for i in 0..<count {
            let vertex = vertexArr[i]
            var node = vertex.next
            while node != nil {
                let edge = ListEdge(start: vertex.value, end: node!.value, startIndex: i, endIndex: node!.index, weight: node!.weighted)
                edges.append(edge)
                node = node!.next
            }
        }
        
        // 对数组按照权值大小进行排序
        edges.sort {
            return $0.weight < $1.weight
        }
        return edges
    }
    
    /// 获取顶点在当前最小生成树中的终点下标
    ///
    /// - Parameter from: 顶点下标
    /// - Returns: 在当前最小生成树的终点下标
    private func getEndVertexIndex(vendes: inout [Int], from: Int) -> Int {
        var end = from
        while vendes[end] != 0 {
            end = vendes[end]
        }
        return end
    }
    
    /// 打印Kruskal算法生成的最小生成树
    ///
    /// - Parameter edges: 边数组
    private func printKruskalMST(edges: [ListEdge<T>]) {
        Swift.print("Kruskal算法最小生成树结果: ", terminator: "")
        for listEdge in edges {
            Swift.print("<\(listEdge.start),\(listEdge.end)>(\(listEdge.weight)) ", terminator: "")
        }
        Swift.print("")
    }
}

// MARK: - 最短路径：迪杰斯特拉算法
extension ListGraph {
    /// 迪杰斯特拉算法
    /// 参考链接：https://www.cnblogs.com/skywang12345/p/3711512.html
    /// - Parameter from: 起始顶点
    func dijkstra(from: T) {
        guard let f = indexOf(from) else {
            return
        }
        
        /// dis数组记录已求出最短路径的顶点以及该顶点到起始顶点的最短路径距离信息
        var dis = [ListNode<T>]()
        /// unDis数组记录还未求出最短路径的顶点以及该顶点到起始顶点的距离信息
        var unDis = [ListNode<T>]()
        /// 顶点是否已访问
        var visited = [Bool](repeating: false, count: count)
        
        // 初始化数组，将起始顶点加入到dis中，最短距离设置为0
        unDis.append(contentsOf: vertexArr)
        let fromNode = unDis.remove(at: f)
        fromNode.distance = 0
        dis.append(fromNode)
        
        // 设置起始顶点已被访问
        visited[f] = true
        
        // 开始遍历查找最短路径
        while !unDis.isEmpty {
            let preNode = dis.last!
            var nextNode = preNode.next
            
            // 更新unDis数组中的距离信息
            while nextNode != nil {
                let index = nextNode!.index
                let curNode = unDis.first { $0.index == index }
                
                // 在unDis中查找到顶点，并且顶点没有被访问过，才需要更新
                if curNode != nil && !visited[index] {
                    // 最短距离为：前面顶点的 distance + 下一顶点的 weighted，需要和当前值进行比较
                    let distance = preNode.distance + nextNode!.weighted
                    if distance < curNode!.distance {
                        // 更新unDis数组中对应顶点的最短距离信息
                        curNode!.distance = distance
                    }
                }
                nextNode = nextNode?.next
            }
            
            // 查找最小距离顶点，将其加入到dis数组中，同时将unDis数组中对应位置设置为无穷大
            var minIndex = 0
            var minDis = unDis.first!.distance
            for (i, node) in unDis.enumerated() {
                if node.distance < minDis {
                    minDis = node.distance
                    minIndex = i
                }
            }
            
            // 将最小距离顶点加入到dis数组中
            let minNode = unDis.remove(at: minIndex)
            dis.append(minNode)
            visited[minIndex] = true
        }
        
        // 打印最短路径
        printDijkstraPath(from: from, dis: &dis)
    }
    
    /// 打印 Dijkstra 最短路径
    /// - Parameter dis: 最短路径数组
    private func printDijkstraPath(from: T, dis: inout [ListNode<T>]) {
        Swift.print("从顶点【\(from)】到图中所有顶点的最短路径为：", terminator: "")
        for node in dis {
            let distance = node.distance == Int.max ? "∞" : node.distance.description
            Swift.print("\(node.value)(\(distance)) ", terminator: "")
        }
        Swift.print("")
    }
}
