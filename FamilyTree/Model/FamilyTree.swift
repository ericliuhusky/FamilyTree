//
//  FamilyTree.swift
//  FamilyTree
//
//  Created by 刘子豪 on 2021/4/30.
//

import Foundation
import SwiftyJSON

/// 家谱，树形结构
class FamilyTree {
    var root: Person?
    
    init(root: Person? = nil) {
        self.root = root
    }
    
    func add(father: Person, child: Person) {
        father.add(child: child)
    }
    
    func remove(father: Person, child: Person) {
        father.remove(child: child)
    }
    
    // 将本数据结构转换为 JSON
    func toJSON() -> JSON? {
        func recursion(person: Person) -> JSON {
            return JSON([
                "name": person.name,
                "children": person.children.map { recursion(person: $0) }
            ])
        }
        guard let root = self.root else { return nil }
        return recursion(person: root)
    }
    
    // 使用 JSON 构造本数据结构
    func from(json: JSON) {
        func recursion(json: JSON) -> Person {
            return Person(
                name: json["name"].stringValue,
                children: json["children"].arrayValue.map { recursion(json: $0) }
            )
        }
        
        self.root = recursion(json: json)
    }
    
    
    //  遍历补全 father 指针，双向链表使得删除速度加快
    func completeFather() {
        func recursion(father: Person?, person: Person) {
            person.father = father
            person.children.forEach { recursion(father: person, person: $0) }
        }
        
        guard let root = self.root else { return }
        recursion(father: nil, person: root)
    }
}
