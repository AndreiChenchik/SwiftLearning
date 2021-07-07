//
//  HistoryView.swift
//  DiceRoller
//
//  Created by Andrei Chenchik on 7/7/21.
//

import SwiftUI

struct HistoryView: View {
    @FetchRequest(entity: Roll.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Roll.date, ascending: false)]) var rolls: FetchedResults<Roll>
    
    @Environment(\.managedObjectContext) var moc

    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationView {
            ZStack {
                if rolls.isEmpty {
                    VStack {
                        Text("History is empty")
                            .padding()
                        Button("Go and Roll something!") {
                            self.selectedTab = 0
                        }
                    }
                } else {
                    List {
                        ForEach(rolls, id: \.self) { roll in
                            HStack {
                                VStack(alignment: .leading) {
                                Text("\(roll.result)")
                                    .font(.headline)
                                Text("Out of \(roll.sides)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("\(formattedDate(from: roll.date))")
                                    .font(.body)
                            }
                        }
                        .onDelete(perform: deleteRolls)
                    }
                }
            }
            .navigationTitle("History of rolls")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.clearHistory()
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Clear")
                        }
                    }
                }
            }
        }
    }
    
    func clearHistory() {
        for roll in rolls {
            moc.delete(roll)
        }
        
        try? moc.save()
    }
    
    func deleteRolls(_ indexSet: IndexSet) {
        for index in indexSet {
            moc.delete(rolls[index])
        }
        
        try? moc.save()
    }
    
    func formattedDate(from date: Date?) -> String {
        guard let date = date else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: date)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(selectedTab: .constant(1))
    }
}
