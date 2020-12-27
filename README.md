# algorithm
#### 使用 Swift 语言实现数据结构与算法之美专栏代码 ，在原有基础上扩增了一些内容，原始代码 https://github.com/wangzheng0822/algo

## 一、目录结构
#### 源代码在第一级目录所对应的文件夹下，测试工程以及测试代码在 [Algorithm](./Algorithm) 目录下，可以直接使用 Xcode 打开工程文件 `Algorithm.xcodeproj`，选择对应的 Target 运行测试代码
![代码组织结构](./Images/example.jpg)

## 二、数据结构内容
![学习路线](./Images/algostudyroute.jpg)

### 数组
- [实现一个支持动态扩容的数组](./Array/Set.swift)
- [实现一个大小固定的有序数组，支持动态增删改操作](./Array/Array.swift)
- [实现两个有序数组合并为一个有序数组](./Array/MergeTwoSortedArray.swift)

### 链表
- 实现[单链表](./LinkedList/SinglyLinkedList.swift)、[循环链表](./LinkedList/LoopLinkedList.swift)、[双向链表](./LinkedList/DoublyLinkedList.swift)，支持增删操作
- [实现单链表反转](./LinkedList/SinglyLinkedList.swift)
- [实现两个有序的链表合并为一个有序链表](./LinkedList/LinkedListFunc.swift)
- [实现求链表的中间结点](./LinkedList/SinglyLinkedList.swift)
- [实现求链表的倒数第K个结点（快慢指针）](./LinkedList/SinglyLinkedList.swift)
- [判断链表是否有环](./LinkedList/LinkedListFunc.swift)
- [链表有环的话，求链表环的入口位置](./LinkedList/LinkedListFunc.swift)

### 栈
- [用数组实现一个顺序栈](./Stack/ArrayStack.swift)
- [用链表实现一个链式栈](./Stack/LinkedListStack.swift)
- [编程模拟实现一个浏览器的前进、后退功能](./Stack/Browser.swift)

### 队列
- [用数组实现一个顺序队列](./Queue/ArrayQueue.swift)
- [用链表实现一个链式队列](./Queue/LinkedListQueue.swift)
- [实现一个循环队列](./Queue/LoopQueue.swift)

### 递归
- [编程实现斐波那契数列求值 f(n) = f(n-1) + f(n-2)](./Recursion/RecursionFunc.swift)
- [编程实现求阶乘 n!](./Recursion/RecursionFunc.swift)
- [编程实现一组数据集合的全排列](./Recursion/RecursionFunc.swift)
- [台阶总共多少走法问题](./Recursion/RecursionFunc.swift)
- [递归常见问题](./Recursion/RecursionFunc.swift)

### 排序算法
- [冒泡排序、插入排序、希尔排序、选择排序](./Sort/BubbleInsertionSelectionFunc.swift)
- [归并排序](./Sort/MergeSortFunc.swift)、[快速排序](./Sort/QuickSort.swift)
- [桶排序、计数排序、基数排序（未实现）](./Sort/LinearSort.swift)
- [编程实现O(n)时间复杂度内找到一组数据的第K大元素](./Sort/SortFunc.swift)

### 二分查找
- [实现一个有序数组的二分查找算法](./BinarySearch/BinarySearch.swift)
- [实现一个数的平方根求解，要求精确到小数点后六位](./BinarySearch/SqrtFunc.swift)
- [实现模糊二分查找算法（比如大于等于给定值的第一个元素）](./BinarySearch/VagueBinarySearch.swift)
- [实现循环有序数组查找给定值](./BinarySearch/LoopSortArrayFunc.swift)

### 跳表
- [实现跳表](./SkipList/SkipList.swift)

### 散列表
 - [实现一个基于链表法解决冲突问题的散列表](./HashTable/HashTable.swift)
 - [实现一个LRU缓存淘汰算法](./HashTable/LRUBaseHashTable.swift)
 
 ### 二叉树
 - [实现一个二叉查找树，并且支持插入、删除、查找操作](./BinaryTree/BinarySearchTree.swift)
 - [实现查找二叉查找树中某个结点的后继、前驱结点](./BinaryTree/BinarySearchTree.swift)
 - [实现二叉树的前、中、后序以及按层遍历](./BinaryTree/BinaryTree.swift)
 
 ### 堆
 - [实现一个小顶堆、大顶堆、优先级队列](./Heap/Heap.swift)
 - [实现堆排序](./Heap/HeapSort.swift)
 - [利用优先级队列合并K个有序数组](./Heap/MergeKSortedArray.swift)
 - [求一组动态数据集合的最大Top K](./Heap/Heap.swift)
 
 ### 图
 - 实现有向图、无向图、有权图、无权图的[邻接矩阵](./Graph/MatrixGraph.swift)和[邻接表](./Graph/ListGraph.swift)表示方法
 - 实现图的[深度优先搜索](./Graph/MatrixGraph.swift)、[广度优先搜索](./Graph/ListGraph.swift)
 - 实现图的[最小生成树](./Graph/ListGraph.swift)算法（Kruskal、Prime）
 - 实现 [Dijkstra](./Graph/ListGraph.swift) 算法、A*算法
 - 实现拓扑排序的 [Kahn 算法](./Graph/TopologicalSort.swift)、[DFS 算法](./Graph/TopologicalSort.swift)
 
 ### 字符串
  - 实现[朴素的字符串匹配算法](./String/BFRKSearch.swift)
  - 实现[BM算法](./String/BMSearch.swift)
  - 实现[KMP算法](./String/KMPSearch.swift)
 - 实现一个字符集，只包含a~z这26个英文字母的[Trie树](./String/Trie.swift)
 
 ### 贪心算法
 - 分糖果、钱币找零、区间覆盖
 - 霍夫曼编码问题
 - [非负整数中，移除K个数字，让剩下的数字值最小](./Greedy/Greedy.swift)
 - n个人等待服务问题，如何安排被服务的先后顺序，使 n 个人总的等待时间最短
 
 ### 分治算法
 - [求一组数据的逆序对个数](./DivideAndConquer/DivideAndConquer.swift)
 
 ### 回溯算法
 - [利用回溯算法求解八皇后问题](./Backtrack/Queens.swift)
 - [利用回溯算法求解0-1背包问题](./Backtrack/Package.swift)
 
 ### 动态规划
 - [0-1背包问题](./DynamicProgramming/PackageDP.swift)
 - [最小路径和](./DynamicProgramming/Chessboard.swift)
 - [编程实现莱文斯坦最短编辑距离](./DynamicProgramming/LevenshteinDistance.swift)
 - [编程实现查找两个字符串的最长公共子序列](./DynamicProgramming/LongestCommonSubsequence.swift)
 - [编程实现一个数据序列的最长递增子序列](./DynamicProgramming/LongestIncreasingSubsequence.swift)
 
 ## 三、LeetCode练习

 ### 数组和链表
 - [三数之和](./LeetCode/015-三数之和/015.swift)
- [求众数](./LeetCode/169-多数元素/169.swift)
- [求缺失的第一个正数](./LeetCode/041-缺失的第一个正数/041.swift)
- [环形链表](./LeetCode/141-环形链表/141.swift)
- [合并K个排序链表](./LeetCode/023-合并K个升序链表/023.swift)
 
 ### 栈、队列和递归
 - [有效的括号](./LeetCode/020-有效的括号/020.swift)
 - 最长有效的括号
 - 逆波兰表达式求值
 - 设计一个双端队列
 - 滑动窗口最大值
 - 爬楼梯
 
 ### 排序和二分查找
 
 ### 散列表和字符串
 
 ### 二叉树和堆
 
 ### 图
 
 ### 贪心、分治、回溯和动态规划
 
 ### 更多 LeetCode 题解请[点击](./LeetCode/LeetCode.md)

 ## 四、学习资源
 ### 1. 可视化工具
 - [VisuAlgo.net](https://visualgo.net/zh)：数据结构与算法动态可视化网站，网站是由 Steven Halim 博士推行建立，初衷是为了帮助新加坡国立大学的学生们，更好的理解数据结构与算法，并进一步强化对各项知识点的吸收；
 - [旧金山大学数据结构与算法可视化网站](https://www.cs.usfca.edu/~galles/visualization/Algorithms.html) ：见名知意，旧金山大学为学生提供的数据结构与算法在线可视化网站，可以直接在网页上面查看算法执行效果；

 ### 2. Swift 数据结构与算法
 - [swift-algorithm-club](https://github.com/raywenderlich/swift-algorithm-club)：[raywenderlich](https://www.raywenderlich.com/) 网站出品的 swift 数据结构与算法书籍答案，非常全面和具体。学习 iOS 的各位都十分清楚，[raywenderlich](https://www.raywenderlich.com/) 网站提供的知识非常靠谱，学起来准没错；
 - [SwiftAlgorithms](https://github.com/thexande/SwiftAlgorithms)：针对 [swift-algorithm-club](https://github.com/raywenderlich/swift-algorithm-club) 编写的开源应用程序；

### 3. LeetCode 相关
 - [LeetCode-Swift](https://github.com/soapyigu/LeetCode-Swift)：Swift 编写的 LeetCode 题解，强大；
 - [LeetCodeAnimation](https://github.com/MisterBooo/LeetCodeAnimation)：图解 LeetCode 算法，使用 Java 语言编写；

 ### 4. 其它语言数据结构与算法
 - [数据结构与算法博客](https://www.cnblogs.com/skywang12345/p/3603935.html)：使用C、C++、Java 语言实现的常见数据结构与算法博客，原理讲的比较透彻，代码编写的比较经典，学习时可以参考下；
 - [algorithms](https://github.com/nibnait/algorithms/blob/master/src/main/java/algorithm_practice/README.md)：使用 Java 语言编写的 《剑指offer》题解；
 - [《编程之法：面试与算法心得》](https://github.com/julycoding/The-Art-Of-Programming-By-July)：书籍配套代码，七月在线科技创始人兼 CEO，CSDN 超人气博客"结构之法算法之道"作者 July 编写，质量有保证，可参考学习；