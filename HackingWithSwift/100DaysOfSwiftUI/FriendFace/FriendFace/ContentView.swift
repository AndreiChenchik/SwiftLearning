//
//  ContentView.swift
//  FriendFace
//
//  Created by Andrei Chenchik on 21/6/21.
//

import SwiftUI




struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K == %d", "isActive", true)) var users: FetchedResults<User>
    
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var isShowingAlert = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    NavigationLink(
                        destination: UserView(user: user),
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
        guard users.count == 0 else { return }
        
        let loader = UsersLoader()
                
        loader.loadData() { jsonData, error in
            if let error = error {
                alertTitle = "Can't load data"
                alertMessage = error.localizedDescription
                isShowingAlert = true
                return
            } else {
                guard let jsonData = jsonData else { fatalError("Should be the data") }
                
                var newUsers = [User]()
                
                for jsonUser in jsonData {
                    let newUser = User(context: self.moc)
                    
                    
                    newUser.externalId = jsonUser.id
                    newUser.age = Int16(jsonUser.age)
                    newUser.name = jsonUser.name
                    newUser.company = jsonUser.company
                    newUser.email = jsonUser.email
                    newUser.address = jsonUser.address
                    newUser.about = jsonUser.about
                    newUser.registered = jsonUser.registered
                    newUser.tags = jsonUser.formattedTags
                    newUser.isActive = jsonUser.isActive
                    
                    for friend in jsonUser.friends {
                        if let friend = newUsers.first(where: { $0.wrappedExternalId == friend.id }) {
                            newUser.addToFriends(friend)
                        }
                    }
                    
                    newUsers.append(newUser)
                }
                
                do {
                    try self.moc.save()
                } catch {
                    alertTitle = "Can't save data"
                    alertMessage = error.localizedDescription
                    isShowingAlert = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
