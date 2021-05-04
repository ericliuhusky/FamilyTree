//
//  Node.swift
//  FamilyTree
//
//  Created by 刘子豪 on 2021/4/30.
//

import SwiftUI

/// 结点视图
struct Node: View {
    let person: Person
    
    @EnvironmentObject var family: Family
    
    @State var isPresented = false
    @State var text: String = ""
    
    var body: some View {
        // 双击编辑，单机操作更好；这里暂且单击编辑，双击更改
        TextField("", text: $text, onEditingChanged: { _ in }, onCommit: {            
            family.rename(person: person, name: text)
        })
        .onAppear {
            text = person.name
        }
        // MARK: style
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10).stroke())
            
        // MARK: action
        .actionSheet(isPresented: $isPresented, content: {
            ActionSheet(title: Text("操作"),
                        message: Text("如何对待\(person.name)？"),
                        buttons: [
                            .default(Text("添加孩子"), action: {
                                family.add(person: person)
                            }),
                            .destructive(Text("删除"), action: {
                                family.remove(person: person)
                            }),
                            .cancel(Text("取消"))])
        })
        .onTapGesture(count: 2) {
            isPresented = true
        }
    }
}

struct Node_Previews: PreviewProvider {
    static var previews: some View {
        Node(person: Person(name: "0"))
    }
}
