//
//  Person.swift
//  FamilyTree
//
//  Created by 刘子豪 on 2021/4/30.
//

import Foundation

/// 人类个体，遵循 `Identifiable` 协议
class Person: Identifiable {
    // 名字
    var name: String
    // 双向指针，便于从父节点删除
    var father: Person? = nil
    // 子结点数组
    var children: [Person]
    
    init(name: String, children: [Person] = []) {
        self.name = name
        self.children = children
    }
    
    func add(child: Person) {
        child.father = self
        children.append(child)
    }
    
    func remove(child: Person) {
        child.father = nil
        children.removeAll(where: { $0.id == child.id })
    }
}

/*
 扩展个人信息
 
 性别
 年龄
 手机号
 微信
 地址
 身份证号
 身高
 肖像
 
 */
