//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Andrei Chenchik on 18/6/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.data.type) {
                        ForEach(0 ..< Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                }
                
                Stepper(value: $order.data.quantity, in: 3...20) {
                    Text("Number of cakes: \(order.data.quantity)")
                }
                
                Section {
                    Toggle(isOn: $order.data.specialRequestEnabled.animation(), label: {
                        Text("Any special requests?")
                    })
                    
                    if order.data.specialRequestEnabled {
                        Toggle(isOn: $order.data.extraFrosting, label: {
                            Text("Add extra frosting")
                        })
                        
                        Toggle(isOn: $order.data.addSprinkles, label: {
                            Text("Add extra sprinkles")
                        })
                    }
                }
                
                Section {
                    NavigationLink(
                        destination: AddressView(order: order),
                        label: {
                            Text("Delivery details")
                        })
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
