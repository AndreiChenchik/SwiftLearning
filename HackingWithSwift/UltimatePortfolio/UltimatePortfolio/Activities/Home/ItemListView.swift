//
//  ItemListView.swift
//  UltimatePortfolio
//
//  Created by Andrei Chenchik on 15/7/21.
//

import SwiftUI

struct ItemListView: View {
    let title: LocalizedStringKey
    @Binding var items: ArraySlice<Item>

    var body: some View {
        if items.isEmpty {
            EmptyView()
        } else {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top)

            ForEach(items, content: ItemListRowView.init)
        }
    }
}
