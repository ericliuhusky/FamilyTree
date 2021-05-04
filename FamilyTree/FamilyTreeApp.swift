//
//  FamilyTreeApp.swift
//  FamilyTree
//
//  Created by 刘子豪 on 2021/4/30.
//

import SwiftUI

@main
struct FamilyTreeApp: App {
    var body: some Scene {
        WindowGroup {
            Tree()
                .environmentObject(Family())
        }
    }
}
