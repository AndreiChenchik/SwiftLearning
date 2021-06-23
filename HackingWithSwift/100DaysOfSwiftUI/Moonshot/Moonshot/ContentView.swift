//
//  ContentView.swift
//  Moonshot
//
//  Created by Andrei Chenchik on 15/6/21.
//

import SwiftUI

struct ToolbarButtonView: View {
    @Binding var showingMissionDatesNotCrew: Bool
    
    var body: some View {
        Text("ASDASD")
    }
}


struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showingMissionDatesNotCrew = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(
                    destination: MissionView(astronauts: self.astronauts, mission: mission, missions: missions),
                    label: {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading, content: {
                            Text(mission.displayName)
                                .font(.headline)
                            self.showingMissionDatesNotCrew ? Text(mission.formattedLaunchDate) : Text(mission.crewDescription)
                        })
                    })
            }
            .navigationTitle("Moonshot")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Text("")
                            .accessibilityHidden(true)
                        
                        Button(action: {
                            self.showingMissionDatesNotCrew.toggle()
                        }, label: {
                            if self.showingMissionDatesNotCrew {
                                Image(systemName: "person.3.fill")
                                    .accessibilityElement()
                                    .accessibility(label: Text("show missions crew in list"))
                            } else {
                                Image(systemName: "calendar")
                                    .accessibilityElement()
                                    .accessibility(label: Text("show missions dates in list"))
                            }
                        })
                        
                    }
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
