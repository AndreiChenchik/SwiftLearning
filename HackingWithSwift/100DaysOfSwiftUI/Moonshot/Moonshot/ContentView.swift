//
//  ContentView.swift
//  Moonshot
//
//  Created by Andrei Chenchik on 15/6/21.
//

import SwiftUI


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
                ToolbarItem {
                    Button(action: {
                        self.showingMissionDatesNotCrew.toggle()
                    }, label: {
                        self.showingMissionDatesNotCrew ? Image(systemName: "person.3.fill") : Image(systemName: "calendar")
                    })
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
