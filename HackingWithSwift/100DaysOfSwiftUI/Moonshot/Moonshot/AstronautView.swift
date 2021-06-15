//
//  AstronautView.swift
//  Moonshot
//
//  Created by Andrei Chenchik on 15/6/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let astronauts: [Astronaut]
    
    let missions: [Mission]
    
    var astronautMissions: [Mission] {
        var matches = [Mission]()
        
        for mission in missions {
            for member in mission.crew {
                if member.name == astronaut.id {
                    matches.append(mission)
                }
            }
        }
        
        return matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    ForEach(astronautMissions) { mission in
                        NavigationLink(
                            destination: MissionView(astronauts: astronauts, mission: mission, missions: missions),
                            label: {
                                HStack {
                                    Image(mission.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 60, height: 60)
                                        .scaledToFit()
                                    
                                    VStack(alignment: .leading) {
                                        Text(mission.displayName)
                                        Text(mission.formattedLaunchDate)
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                            })
                            .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], astronauts: astronauts, missions: missions)
    }
}
