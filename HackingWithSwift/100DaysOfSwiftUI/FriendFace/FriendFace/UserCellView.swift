//
//  UserCellView.swift
//  FriendFace
//
//  Created by Andrei Chenchik on 21/6/21.
//

import SwiftUI

struct UserCellView: View {
    @State var user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(user.wrappedName)
                .font(.headline)
            
            Text(user.wrappedEmail)
        }
    }
}

//struct UserCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCellView()
//    }
//}
