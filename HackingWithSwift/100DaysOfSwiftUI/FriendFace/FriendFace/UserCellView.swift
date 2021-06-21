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
            Text(user.name)
                .font(.headline)
            
            Text(user.email)
        }
    }
}

//struct UserCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCellView()
//    }
//}
