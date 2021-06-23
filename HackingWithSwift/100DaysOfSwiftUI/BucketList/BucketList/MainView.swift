//
//  MainView.swift
//  BucketList
//
//  Created by Andrei Chenchik on 23/6/21.
//

import SwiftUI
import MapKit

struct MainView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    
    @State private var showingEditScreen = false
    
    @State private var locations = [CodableMKPointAnnotation]()
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.coordinate = centerCoordinate

                        selectedPlace = newLocation
                                            
                        self.locations.append(newLocation)
                        showingEditScreen = true
                    }, label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    })
                    
                }
            }
        }
        .onAppear(perform: loadData)
        .alert(isPresented: $showingPlaceDetails, content: {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information"), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                self.showingEditScreen = true
            })
        })
        .sheet(isPresented: $showingEditScreen, onDismiss: {
            if (selectedPlace?.title ?? "").isEmpty {
                selectedPlace?.title = "Unknown place"
            }
            saveData()
        }, content: {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            } else {
                Text("No place selected!")
            }
        })
    }
    
    func loadData() {
        if let locationsData: [CodableMKPointAnnotation] = FileManager.default.decode(from: "SavedPlaces") {
            locations = locationsData
        }
    }
    
    func saveData() {
        FileManager.default.encode(locations, to: "SavedPlaces")
    }
}

