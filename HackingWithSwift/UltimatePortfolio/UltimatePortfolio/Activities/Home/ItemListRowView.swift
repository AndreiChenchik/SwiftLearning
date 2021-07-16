//
//  ItemListRowView.swift
//  UltimatePortfolio
//
//  Created by Andrei Chenchik on 15/7/21.
//

import SwiftUI

struct ItemListRowView: View {
    @ObservedObject var item: Item

    var body: some View {
        NavigationLink(destination: EditItemView(item: item)) {
            HStack(spacing: 20) {
                Circle()
                    .stroke(Color(item.project?.projectColor ?? "Light Blue"), lineWidth: 3)
                    .frame(width: 44, height: 44)

                VStack(alignment: .leading) {
                    Text(item.itemTitle)
                        .font(.title2)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if item.itemDetail.isEmpty == false {
                        Text(item.itemDetail)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
            .background(Color.secondarySystemGroupedBackground)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.2), radius: 5)
        }
    }
}

struct ItemListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListRowView(item: Item.example)
    }
}
