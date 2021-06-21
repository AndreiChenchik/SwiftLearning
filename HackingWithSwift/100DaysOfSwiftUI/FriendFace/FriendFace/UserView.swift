//
//  UserView.swift
//  FriendFace
//
//  Created by Andrei Chenchik on 21/6/21.
//

import SwiftUI

struct UserView: View {
    let users: Users
    let user: User
    
    var friends: [User] {
        var friends = [User]()
        
        for friend in user.friends {
            if let friend = users.activeUsers.first(where: {$0.id == friend.id}) {
                friends.append(friend)
            }
        }
        
        return friends
    }
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text("\(user.age) years old")
                    Text("Working at \(user.company)")
                    Text("Registration date: \(user.formattedRegisteredDate)")
                    
                    Text("Contact information")
                        .padding(.top)
                        .font(.title)
                    Text(user.email)
                    Text(user.address)
                    
                    Text("About")
                        .padding(.top)
                        .font(.title)
                    Text(user.about)
                    Text("Tags: \(user.formattedTags)")
                    
                    Text("Friends")
                        .padding(.top)
                        .font(.title)
                }
            }
            ForEach(friends) { user in
                NavigationLink(
                    destination: UserView(users: users, user: user),
                    label: {
                        UserCellView(user: user)
                    })
            }
        }
        .navigationTitle(user.name)
    }
}

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView()
//    }
//}
