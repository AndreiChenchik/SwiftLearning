//
//  ContentView.swift
//  FriendFace
//
//  Created by Andrei Chenchik on 21/6/21.
//

import SwiftUI




struct ContentView: View {
    @StateObject var users = Users()
    
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users.activeUsers) { user in
                    NavigationLink(
                        destination: UserView(users: users, user: user),
                        label: {
                            UserCellView(user: user)
                        })
                }
            }
            .navigationTitle("FriendFace")
            .onAppear(perform: loadUsers)
            .alert(isPresented: $isShowingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: loadUsers, label: {
                        Image(systemName: "arrow.clockwise")
                    })
                }
            }
            
        }
    }
    
    
    func loadUsers() {
        users.loadData() { error in
            alertTitle = "Can't load data"
            alertMessage = error.localizedDescription
            isShowingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
