//
//  ContentView.swift
//  AnimationExperiment
//
//  Created by Andrei Chenchik on 13/12/21.
//

import SwiftUI

struct ContentView: View {
    @State var toggleOn: Bool = true

    var body: some View {
        Form {
            Text("Hello, world!")
                .padding()
            Toggle("Hello", isOn: $toggleOn)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
