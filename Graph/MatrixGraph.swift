//
//  MatrixGraph.swift
//  Graph
//
//  Created by ggl on 2020/6/17.
//  Copyright © 2020 ggl. All rights reserved.
//  邻接矩阵图(数组)

import Foundation

/// 邻接矩阵图的类型
enum MatrixGraphType {
    // 无向的
    case Undirected
    
    // 有向的
    case Directed
}

/// 邻接矩阵
class MatrixGraph<T: Equatable & CustomStringConvertible> {
    /// 存储的顶点个数
    private(set) var count: Int
    
    /// 顶点数组，用来存储顶点
    private var vertexArr: [T]
    
    /// 邻接矩阵数组，存储顶点之间的边关系
    private var adj: [[Int]]
    
    /// 图的类别
    private let type: MatrixGraphType
    
    /// 深度优先搜索辅助变量
    private var found: Bool = false
    
    /// 初始化图
    /// - Parameters:
    ///   - type: 图的类别，有向图或无向图
    init(type: MatrixGraphType) {
        self.type = type
        self.vertexArr = []
        self.adj = []
        count = 0
    }
    
    /// 添加顶点
    /// - Parameter vertex: 顶点
    @discardableResult
    func addVertex(_ vertex: T) -> Self {
        count += 1
        // 添加顶点
        vertexArr.append(vertex)
        for i in 0..<count {
            if i == count - 1 {
                // 添加新数组
                adj.append([Int](repeating: 0, count: count))
            } else {
                // 原有数组上面，添加0元素来补齐矩阵
                adj[i].append(0)
            }
        }
        return self
    }
    
    /// 查找顶点对应的下标
    /// - Parameter vertex: 顶点
    func indexOf(_ vertex: T) -> Int? {
        return vertexArr.firstIndex(of: vertex)
    }
    
    /// 添加两个顶点之间的边关系
    /// - Parameters:
    ///   - from: 从哪个顶点
    ///   - to: 到哪个顶点
    ///   - weighted: 边的权重，默认为1
    @discardableResult
    func addEdge(from: T, to: T, weighted: Int = 1) -> Bool {
        guard let f = indexOf(from), let t = indexOf(to), f != t else {
            return false
        }
        // 权重不能等于0，0 被认为是顶点之间没有关系
        let validWT = weighted < 1 ? 1 : weighted
        switch type {
        case .Directed:
            // 有向图
            adj[f][t] = validWT
        case .Undirected:
            // 无向图
            adj[f][t] = validWT
            adj[t][f] = validWT
        }
        return true
    }
    
    /// 广度优先搜索
    func bfs(from: T, to: T) {
        guard let f = indexOf(from), let t = indexOf(to), f != t else {
            return
        }
        
        // 记录顶点是否已被访问数组
        var visited = [Bool](repeating: false, count: count)
        // 记录顶点访问路径
        var prev = [Int](repeating: -1, count: count)
        // 层级遍历队列
        var queue = [Int]()
        
        // 开始进行层级遍历
        visited[f] = true
        queue.append(f)
        while !queue.isEmpty {
            let index = queue.remove(at: 0)
            for i in 0..<count {
                // 判断权重是否大于0
                let weight = adj[index][i]
                if weight < 1 {
                    continue
                }
                
                // 判断顶点是否已被访问
                if !visited[i] {
                    // 记录顶点访问路径
                    prev[i] = index
                    
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
            }
        }
    }
    
    /// 深度优先搜索
    func dfs(from: T, to: T) {
        guard let f = indexOf(from), let t = indexOf(to), f != t else {
            return
        }
        // 顶点是否访问数组
        var visited = [Bool](repeating: false, count: count)
        // 顶点访问路径数组
        var prev = [Int](repeating: -1, count: count)
        // 递归查找
        recurDfs(from: f, to: t, visited: &visited, prev: &prev)
        
        // 如果找到了路径
        if found {
            Swift.print("从顶点\(from)到顶点\(to)的访问路径(深度优先搜索)：", terminator: "")
            print(prev: &prev, from: f, to: t)
            Swift.print("")
            found = false
        }
    }
    
    /// 递归遍历
    private func recurDfs(from: Int, to: Int, visited: inout [Bool], prev: inout [Int]) {
        if found {
            return
        }
        visited[from] = true
        
        // 如果要找的结点与目的结点相同，则结束
        if from == to {
            found = true
            return
        }
        
        // 深度遍历
        for i in 0..<count {
            // 权重
            let weight = adj[from][i]
            if weight < 1 {
                continue
            }
            
            // 继续遍历
            if !visited[i] {
                prev[i] = from
                recurDfs(from: i, to: to, visited: &visited, prev: &prev)
            }
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
        Swift.print("\(vertexArr[to]) ", terminator: "")
    }
    
    /// 打印图
    func print() {
        // 打印标题
        Swift.print("\(type == .Directed ? "邻接矩阵有向图" : "邻接矩阵无向图") =》")
        Swift.print("  ", terminator: "")
        for vertex in vertexArr {
            Swift.print(vertex, terminator: " ")
        }
        Swift.print("")
        
        // 打印矩阵内容
        for i in 0..<count {
            Swift.print("\(vertexArr[i]) ", terminator: "");
            for j in 0..<count {
                Swift.print(adj[j][i], terminator: " ")
            }
            Swift.print("");
        }
    }
}
