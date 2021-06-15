//
//  MissionView.swift
//  Moonshot
//
//  Created by Andrei Chenchik on 15/6/21.
//

import SwiftUI

struct MissionView: View {
    let astronauts: [Astronaut]
    
    let mission: Mission
    let missions: [Mission]
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    var crewMembers: [CrewMember] {
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        return matches
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text(self.mission.displayName)
                        .font(.largeTitle)
                        .padding()
                    
                    Text(self.mission.description)
                        .padding()
                        .layoutPriority(1)
                    
                    ForEach(self.crewMembers, id: \.role) { crewMember in
                        NavigationLink(
                            destination: AstronautView(astronaut: crewMember.astronaut, astronauts: astronauts, missions: missions),
                            label: {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 83, height: 60)
                                        .clipShape(Capsule())
                                        .overlay(Capsule()
                                                    .stroke(Color.primary, lineWidth: 1))
                                    VStack(alignment: .leading, content: {
                                        Text(crewMember.astronaut.name)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundColor(.secondary)
                                    })
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                            })
                            .buttonStyle(PlainButtonStyle())

                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationTitle(Text(mission.displayName))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(astronauts: astronauts, mission: missions[0], missions: missions)
    }
}
