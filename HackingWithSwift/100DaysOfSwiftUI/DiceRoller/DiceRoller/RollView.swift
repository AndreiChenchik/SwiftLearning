//
//  RollView.swift
//  DiceRoller
//
//  Created by Andrei Chenchik on 7/7/21.
//

import SwiftUI
import Combine
import CoreHaptics

struct RollView: View {
    static let timerPrecision = 0.1
    static let rollingTime = 3.0
    static var counterLimit: Int {
        Int(Self.rollingTime / Self.timerPrecision)
    }
    
    @Environment(\.managedObjectContext) var moc
    
    let sidesVariety = [4, 6, 8, 10, 12, 20, 100]

    @State var sidesSelection = 6

    @State var isFinishedRolling = false
    
    @State var rollResult = 0
    @State var rollSides = 0
    @State var visibleSide = 0
    
    @State private var timer = Timer.publish(every: Self.timerPrecision, on: .main, in: .common).autoconnect()
    
    @State var nextSideReveal = 0
    @State private var counter = 0
    
    @State private var engine: CHHapticEngine?
    
    var diceDisplay: String {
        if isFinishedRolling { return "\(rollResult)" }
        if visibleSide != 0 { return "\(visibleSide)" }
        return "?"
    }
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    Spacer()
                    
                    ZStack(alignment: .bottomTrailing) {
                        Text(diceDisplay)
                            .font(.system(size: 64))
                            .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5)
                            .foregroundColor(.white)
                            .background(Color.green.opacity(0.75))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        if isFinishedRolling {
                            Text("out of \(rollSides)")
                                .foregroundColor(.white)
                                .padding(8)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Select number of sides")
                    Picker("Number of sides", selection: $sidesSelection) {
                        ForEach(sidesVariety, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: geo.size.width * 0.6)
                    .padding(.bottom, 40)
                    
                    Button(action: startRolling) {
                        HStack {
                            Image(systemName: "shuffle")
                            Text(rollResult == 0 ? "Roll the dice!" : "Roll again!" )
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.bottom, 50)
                        .animation(.spring())
                    }
                }
                .frame(width: geo.size.width)
                .navigationTitle("Dice Roller")
            }
        }
        .onAppear(perform: cancelTimer)
        .onDisappear(perform: cancelTimer)
        .onReceive(timer, perform: rolling)
    }
    
    func rolling(_ time: Publishers.Autoconnect<Timer.TimerPublisher>.Output) {
        if counter > Self.counterLimit {
            endRolling()
            counter = 0
        } else {
            counter += 1
            if counter > nextSideReveal {
                revealSide()
                nextSideReveal = Int(Double(counter) * 1.3)
            }
        }
    }
    
    func cancelTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startRolling() {
        cancelTimer()
        timer = Timer.publish(every: Self.timerPrecision, tolerance: 0.2, on: .main, in: .common).autoconnect()
        
        isFinishedRolling = false
        counter = 0
        nextSideReveal = 0
        
        prepareHaptics()
    }
    
    func revealSide() {
        visibleSide = Int.random(in: 1...sidesSelection)
        revealHaptics()
    }
    
    func endRolling() {
        let sides = Int16(sidesSelection)
        let result = Int16.random(in: 1...sides)
        
        rollResult = Int(result)
        rollSides = Int(sides)
        
        cancelTimer()
        isFinishedRolling = true
        
        endRollingHaptics()
        
        let roll = Roll(context: moc)
        roll.date = Date()
        roll.sides = sides
        roll.result = result
        
        try? moc.save()
    }
    
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func revealHaptics() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    func endRollingHaptics() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
