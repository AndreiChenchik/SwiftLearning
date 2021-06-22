//
//  ContentView.swift
//  Instafilter
//
//  Created by Andrei Chenchik on 21/6/21.
//

import SwiftUI

import CoreImage
import CoreImage.CIFilterBuiltins


struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 100.0
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var filterName = "Sepia Tone"
    let context = CIContext()
    
    @State private var processedImage: UIImage?
    
    @State private var showingFilterSheet = false
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        let intensity = Binding<Double>(get: {
            self.filterIntensity
        }, set: {
            self.filterIntensity = $0
            self.applyProcessing()
        })
        
        let radius = Binding<Double>(get: {
            self.filterRadius
        }, set: {
            self.filterRadius = $0
            self.applyProcessing()
        })
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }.padding(.top)
                
                HStack {
                    Text("Radius")
                    Slider(value: radius, in: 0...200)
                }.padding(.vertical)
                
                HStack {
                    Button(filterName) {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            alertTitle = "Saving Error"
                            alertMessage = "There is no picture to save"
                            showingAlert = true
                            return
                        }
                        
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Success!")
                        }

                        imageSaver.errorHandler = {
                            alertTitle = "Saving Error"
                            alertMessage = $0.localizedDescription
                            showingAlert = true
                        }

                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage, content: {
                ImagePicker(image: self.$inputImage)
            })
            .actionSheet(isPresented: $showingFilterSheet, content: {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) {
                        self.setFilter(CIFilter.crystallize())
                        self.filterName = "Crystallize"
                    },
                    .default(Text("Edges")) {
                        self.setFilter(CIFilter.edges())
                        self.filterName = "Edges"
                    },
                    .default(Text("Gaussian Blur")) {
                        self.setFilter(CIFilter.gaussianBlur())
                        self.filterName = "Gaussian Blur"
                    },
                    .default(Text("Pixellate")) {
                        self.setFilter(CIFilter.pixellate())
                        self.filterName = "Pixellate"
                    },
                    .default(Text("Sepia Tone")) {
                        self.setFilter(CIFilter.sepiaTone())
                        self.filterName = "Sepia Tone"
                    },
                    .default(Text("Unsharp Mask")) {
                        self.setFilter(CIFilter.unsharpMask())
                        self.filterName = "Unsharp Mask"
                    },
                    .default(Text("Vignette")) {
                        self.setFilter(CIFilter.vignette())
                        self.filterName = "Vignette"
                    },
                    .cancel()
                ])
            })
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            })
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}
