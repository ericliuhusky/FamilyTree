//
//  Family.swift
//  FamilyTree
//
//  Created by 刘子豪 on 2021/5/2.
//

import Foundation
import SwiftUI
import SwiftyJSON

/// 视图模型
class Family: ObservableObject {
    @Published var tree: FamilyTree
    
    // UserDefault 用户缓存
    @AppStorage("familyTreeJson") var familyTreeJson: String = ""

    init() {
        self.tree = FamilyTree()
        
        read()
    }
    
    /// 读取
    func read() {
        tree.from(json: JSON(parseJSON: familyTreeJson))
        
        tree.completeFather()
    }
    
    /// 写数据
    func write() {
        guard let json = self.tree.toJSON()?.rawString() else { return }
        familyTreeJson = json
    }
    
    func add(person: Person) {
        tree.add(father: person, child: Person(name: ""))
        
        // 通知观察者，观察对象将要更新
        // []数组是不需要此操作的，似乎只有自定义数据类型如此处的tree树可能需要此操作
        self.objectWillChange.send()
        
        write()
    }
    
    func remove(person: Person) {
        guard let father = person.father else { return }
        tree.remove(father: father, child: person)
        
        self.objectWillChange.send()
        
        write()
    }
    
    func rename(person: Person, name: String) {
        // 在Tree视图中可观察对象的Published属性tree通过递归的方式渲染出树形结构，层层传递都是值传递，因为结点是Person(class)
        // 因此在这里可以直接更改所传进来的person引用的name属性，进而更改了本实例的tree中的某person的name属性
        person.name = name
        
        write()
    }
}
