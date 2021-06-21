//
//  UserView.swift
//  FriendFace
//
//  Created by Andrei Chenchik on 21/6/21.
//

import SwiftUI

struct UserView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>
    
    let user: User
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text("\(user.age) years old")
                    Text("Working at \(user.wrappedCompany)")
                    Text("Registration date: \(user.formattedRegisteredDate)")
                    
                    Text("Contact information")
                        .padding(.top)
                        .font(.title)
                    Text(user.wrappedEmail)
                    Text(user.wrappedAddress)
                    
                    Text("About")
                        .padding(.top)
                        .font(.title)
                    Text(user.wrappedAbout)
                    Text("Tags: \(user.wrappedTags)")
                    
                    Text("Friends")
                        .padding(.top)
                        .font(.title)
                }
            }
            ForEach(user.friendsArray, id: \.self) { user in
                NavigationLink(
                    destination: UserView(user: user),
                    label: {
                        UserCellView(user: user)
                    })
            }
        }
        .navigationTitle(user.wrappedName)
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
