//
//  ShoppingCart.swift
//  DynamicProgramming
//
//  Created by ggl on 2020/8/22.
//  Copyright © 2020 ggl. All rights reserved.
//  购物车问题（动态规划）

import Foundation

/**
 * 淘宝的"双十一"购物节有各种促销活动，比如"满 200 元减 50 元"。
 * 假设购物车中有 n 个（n>100）想买的商品，我们希望从里面选几个，在凑够满减条件的前提下，
 * 让选出来的商品价格总和最大程度地接近满减条件（200 元），这样就可以极大限度地"薅羊毛"，
 * 如何解决这个问题呢？
 */

// 备忘录，防止计算重复状态
private var itemStateMap = [String: Bool]()

// 最终物品清单数组
private var itemsResults = [[Int]]()

/// 获取最终可承受支付价格
///
/// - Parameter coupon: 满减条件
/// - Returns: 通过满减条件转换后的最后支付价格
private func maxPrice(coupon: Int) -> Int {
    return Int(Double(coupon) * 1.5)
}

/// 购物车解决方案
///
/// - Parameters:
///   - items: 购物车商品数组
///   - coupon: 满减条件，比如"满 200 元减 50 元"，则传200
func shoppingCart(items: [Int], coupon: Int) -> (price: [Int], items: [[Int]]) {
    // 最终可忍受价格
    let loadBearingPrice = maxPrice(coupon: coupon)
    // 状态转移数组
    var states = [Bool](repeating: false, count: loadBearingPrice+1)
    
    // 第一件商品状态特殊处理
    // 不购买第一件商品
    states[0] = true
    if items[0] <= loadBearingPrice {
        // 购买第一件商品
        states[items[0]] = true
    }
    
    // 处理剩余的其他商品
    for i in 1..<items.count {
        for j in (0...(loadBearingPrice - items[i])).reversed() {
            if states[j] {
                states[j+items[i]] = true
            }
        }
    }
    
    // 筛选输出选择范围结果
    var priceResults = [Int]()
    for i in coupon...loadBearingPrice {
        if states[i] {
            priceResults.append(i)
        }
    }
    
    // 输出选择的对应商品
    for result in priceResults {
        // 使用递归求解物品清单，使用文章中提供的方式存在一定的问题
        // 重置递归状态
        var shoppingItems = [Int](repeating: 0, count: items.count)
        itemStateMap.removeAll()
        
        // 递归求购买的物品清单
        recurFindItems(curIndex: 0, items: items, price: result, shoppingItems: &shoppingItems)
        
        /**
         * 下面求解的方式存在问题，例如：
         * 购物车商品价格: [68, 64, 32, 41, 88], 优惠券价值: 200, 可使用优惠券购买最优惠价格范围为: [205, 220, 225, 229, 252, 261, 293]
         * 可使用优惠券购买最优惠价格范围为: 205, 对应购买的商品为: [68, 64, 32, 41, 0](205)
         * 可使用优惠券购买最优惠价格范围为: 220, 对应购买的商品为: [68, 0, 32, 0, 88](188)
         * 可使用优惠券购买最优惠价格范围为: 225, 对应购买的商品为: [0, 64, 32, 41, 88](225)
         * 可使用优惠券购买最优惠价格范围为: 229, 对应购买的商品为: [68, 0, 32, 41, 88](229)
         * 可使用优惠券购买最优惠价格范围为: 252, 对应购买的商品为: [68, 64, 32, 0, 88](252)
         * 可使用优惠券购买最优惠价格范围为: 261, 对应购买的商品为: [68, 0, 32, 41, 88](229)
         * 可使用优惠券购买最优惠价格范围为: 293, 对应购买的商品为: [68, 64, 32, 41, 88](293)
         */
        /*
        // 选择的商品
        var finalPrice = result
        var shoppingItems = items
        for i in (0..<items.count).reversed() {
            // 上一个商品决策时的商品总价
            let prePrice = finalPrice - items[i]
            if prePrice >= 0 && states[prePrice] {
                // 选择了当前i这个商品
                finalPrice = prePrice
            } else {
                // 没有选择当前i这个商品
                shoppingItems[i] = 0
            }
        }
        // 加入到结果集合中
        itemsResults.append(shoppingItems)*/
    }
    
    return (priceResults, itemsResults)
}

/// 根据购物总价格，递归查找购买的物品清单
///
/// - Parameters:
///   - curIndex: 当前考察的下标
///   - items: 物品价格数组
///   - price: 购买总价格
///   - shoppingItems: 购物清单
private func recurFindItems(curIndex: Int, items: [Int], price: Int, shoppingItems: inout [Int]) {
    // 遍历到最后一个物品
    if curIndex >= items.count {
        if price == 0 {
            itemsResults.append(shoppingItems)
        }
        return
    }
    
    // 检查是否有重复计算
    let key = "\(curIndex)+\(price)"
    if let exist = itemStateMap[key], exist {
        return
    }
    itemStateMap[key] = true
    
    // 不加入当前物品
    shoppingItems[curIndex] = 0
    recurFindItems(curIndex: curIndex+1, items: items, price: price, shoppingItems: &shoppingItems)
    
    // 加入当前物品
    if price - items[curIndex] >= 0 {
        shoppingItems[curIndex] = items[curIndex]
        recurFindItems(curIndex: curIndex+1, items: items, price: price-items[curIndex], shoppingItems: &shoppingItems)
    }
}
