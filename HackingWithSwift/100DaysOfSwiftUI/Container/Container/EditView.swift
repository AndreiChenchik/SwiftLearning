//
//  EditView.swift
//  Container
//
//  Created by Andrei Chenchik on 2/7/21.
//

import SwiftUI

struct EditView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var picture: Picture
    
    @State var imageName = ""
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("Captured image")) {
                        Image(uiImage: picture.wrappedImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(10)
                    }
                    
                    Section(header: Text("Name")) {
                        TextField("Caption this picture", text: $imageName)
                    }
                }
                VStack {
                    Spacer()
                    
                    Button(action: {
                        picture.title = imageName
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                            .padding()
                            .background(imageName.isEmpty ? .gray : Color.green)
                            .foregroundColor(.white)
                            .opacity(imageName.isEmpty ? 0.3 : 1)
                            .clipShape(Capsule())
                    })
                    .padding()
                    .disabled(imageName.isEmpty)
                }
            }
            
            .navigationTitle("Add information")
        }
        
        
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView()
//    }
//}
