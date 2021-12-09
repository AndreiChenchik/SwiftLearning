//
//  iOS_ConcurrencyApp.swift
//  iOS Concurrency
//
//  Created by Andrei Chenchik on 9/12/21.
//

import SwiftUI

@main
struct iOS_ConcurrencyApp: App {
    var body: some Scene {
        WindowGroup {
            UsersListView()
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
