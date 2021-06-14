//
//  AddView.swift
//  iExpense
//
//  Created by Andrei Chenchik on 14/6/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    static let types = ["Business", "Personal"]
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertButton = ""
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    expenses.items.append(item)
                    
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.alertTitle = "Can't process amount"
                    self.alertMessage = "Entered amount can't be processed"
                    self.alertButton = "Try again"
                    self.showingAlert = true
                }
            })
            .alert(isPresented: $showingAlert, content: {
                Alert(
                    title: Text(self.alertTitle),
                    message: Text(self.alertMessage),
                    dismissButton: .default(Text(self.alertButton))
                )
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
