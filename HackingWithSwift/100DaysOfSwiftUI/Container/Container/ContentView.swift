//
//  ContentView.swift
//  Container
//
//  Created by Andrei Chenchik on 24/6/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Picture.entity(), sortDescriptors: [NSSortDescriptor(key: "title", ascending: true)]) var pictures: FetchedResults<Picture>
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var showingSourceSelecor = false
    var imageSources: [(String, UIImagePickerController.SourceType)] {
        let allSources: [String: UIImagePickerController.SourceType] = ["Camera": .camera, "Photo Library": .photoLibrary]
        let possibleSources = allSources.filter { UIImagePickerController.isSourceTypeAvailable($0.value) }
        
        let sortedSources = Array(possibleSources).sorted { $0.key < $1.key }
        
        return sortedSources
        
    }
    @State private var selectedImageSource: UIImagePickerController.SourceType?
    
    @State private var showingEditScreen = false
    @State private var selectedPicture: Picture?
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(pictures, id: \.self) { picture in
                        Button {
                            selectedPicture = picture
                        } label: {
                            HStack {
                                Image(uiImage: picture.wrappedImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                
                                Text(picture.wrappedTitle)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(InsetListStyle())
                
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        if imageSources.count > 1 {
                            showingSourceSelecor = true
                        } else {
                            showingImagePicker = true
                        }
                    }, label: {
                        HStack {
                            Image(systemName: "doc.badge.plus")
                            Text("Add Picture")
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                    })
                    .padding()
                }
                
            }
            .navigationTitle("Container")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: processImage) {
                ImagePicker(image: $inputImage, sourceType: selectedImageSource ?? .photoLibrary)
                    .ignoresSafeArea()
            }
            .actionSheet(isPresented: $showingSourceSelecor) {
                var buttons = [ActionSheet.Button]()
                for source in imageSources {
                    buttons.append(.default(Text(source.0), action: {
                        selectedImageSource = source.1
                        showingImagePicker = true
                    }))
                }
                buttons.append(.cancel())
                
                return ActionSheet(title: Text("Select Image Source"), message: nil, buttons: buttons)
            }
            .sheet(item: $selectedPicture, onDismiss: saveData) { picture in
                EditView(picture: picture, imageName: picture.title ?? "")
            }
        }
    }
    
    func processImage() {
        guard let inputImage = inputImage else { return }
        
        let newPicture = Picture(context: moc)
        newPicture.addPicture(inputImage)
        
        selectedPicture = newPicture
    }
    
    func deleteItems(at indexSet: IndexSet) {
        for index in indexSet {
            let picture = pictures[index]
            moc.delete(picture)
        }
        
        saveData()
    }
    
    func saveData() {
        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                let nserror = error as NSError
                fatalError("Saving data error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
