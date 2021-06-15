//
//  ContentView.swift
//  iExpense
//
//  Created by Andrei Chenchik on 14/6/21.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id: UUID
    let name: String
    let type: String
    let amount: Int
    
    var color: UIColor {
        if amount < 10 {
            return UIColor.systemGray2
        }
        
        if amount < 100 {
            return UIColor.systemGray
        }
        
        return UIColor.black
    }
    
    
    init(id: UUID = UUID(), name: String, type: String, amount: Int) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                
                return
            }
        }
        
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expences = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expences.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                    }
                    .foregroundColor(Color(item.color))
                }
                .onDelete(perform: removeItems)
            }
            .listStyle(InsetListStyle())
            .navigationTitle("iExpense")
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        self.showingAddExpense = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            })
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: self.expences)
            })
        }
        
    }
    
    func removeItems(at offsets: IndexSet) {
        expences.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
