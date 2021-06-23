//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Andrei Chenchik on 18/6/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibility(hidden: true)
                    
                    Text("Your total is $\(self.order.data.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation, content: {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        })
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.data) else {
            fatalError("Order data can't be encoded")
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                self.alertTitle = "No data in response"
                self.alertMessage = error?.localizedDescription ?? "Unknown error"
                print("\(alertTitle): \(alertMessage)")
                
                self.showingConfirmation = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(OrderInfo.self, from: data) {
                let quantity = decodedOrder.quantity
                let cakeType = Order.types[decodedOrder.type].lowercased()
                
                self.alertTitle = "Thank you!"
                self.alertMessage = "Your order for \(quantity)x \(cakeType) cupcakes is on it's way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
