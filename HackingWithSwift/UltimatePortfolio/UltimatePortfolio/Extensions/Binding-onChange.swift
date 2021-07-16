//
//  Binding-onChange.swift
//  UltimatePortfolio
//
//  Created by Andrei Chenchik on 13/7/21.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
