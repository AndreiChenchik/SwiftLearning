//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Andrei Chenchik on 6/7/21.
//

import SwiftUI

struct SettingsView: View {
    @Binding var option: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Revert swipe to wrong on first item", isOn: $option)
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
            .listStyle(GroupedListStyle())
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(option: .constant(true))
    }
}
