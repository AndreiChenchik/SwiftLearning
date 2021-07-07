//
//  ContentView.swift
//  DiceRoller
//
//  Created by Andrei Chenchik on 7/7/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
        
    var body: some View {
        TabView(selection: $selectedTab) {
            RollView()
                .tabItem {
                    Image(systemName: "play.circle")
                    Text("Roll it!")
                }
                .tag(0)
            
            HistoryView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("History")
                }
                .tag(1)
        }
    }
    
    func loadData() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
