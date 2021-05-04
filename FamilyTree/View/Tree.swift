//
//  Tree.swift
//  FamilyTree
//
//  Created by 刘子豪 on 2021/4/30.
//

import SwiftUI

/// 树形视图
struct Tree: View {
    @EnvironmentObject var family: Family
    
    var body: some View {
        // 横纵两个方向的滚动视图
        ScrollView(.init(arrayLiteral: .vertical, .horizontal), showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) {
            if let root = family.tree.root {
                Recursion(person: root) { (person) in
                    Node(person: person)
                }
            }
        }
    }
    
    // 非常神奇的一点是，只有把它设置成<Content: View>才能成功更新视图
    /// 递归视图
    struct Recursion<Content: View>: View {
        let person: Person
        
        let content: (Person) -> Content
        
        var body: some View {
            VStack(spacing: 20) {
                // 取消注释下面的语句并注视掉content(person)之后，在content内无论传入什么视图都不会影响成功更新视图
                // Node(person: person)
                content(person)
                
                HStack(alignment: .top, spacing: 20) {
                    ForEach(person.children) { (child) in
                        Recursion(person: child, content: content)
                    }
                }
            }
        }
    }
}



struct Tree_Previews: PreviewProvider {
    static var previews: some View {
        let p = Person(name: "0")
        let p1 = Person(name: "1")
        let p2 = Person(name: "2")
        let p11 = Person(name: "11")
        let p12 = Person(name: "12")
        let p21 = Person(name: "21")
        let familyTree = FamilyTree(root: p)
        p.add(child: p1)
        p.add(child: p2)
        p1.add(child: p11)
        p1.add(child: p12)
        p2.add(child: p21)
        let obj = Family()
        obj.tree = familyTree
        return Tree().environmentObject(obj)
    }
}
