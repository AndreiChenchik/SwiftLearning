//
//  ContentView.swift
//  Habitum
//
//  Created by Andrei Chenchik on 17/6/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habitum = Habitum()
    
    @State private var isSheetVisible = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0 ..< habitum.habits.count, id: \.self) { index in
                    NavigationLink(
                        destination: ActivityView(habitum: self.habitum, index: index),
                        label: {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(habitum.habits[index].title).font(.headline)
                                    Text(habitum.habits[index].description)
                                }
                                
                                Spacer()
                                
                                Text("\(habitum.habits[index].count)")
                            }
                        })
                }
            }
            .navigationTitle("Habitum")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.isSheetVisible = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .sheet(isPresented: $isSheetVisible, content: {
                NewActivityView(habitum: self.habitum)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
