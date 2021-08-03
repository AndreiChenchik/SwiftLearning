//
//  ContentView.swift
//  MonogramViewExample
//
//  Created by Andrei Chenchik on 3/8/21.
//

import SwiftUI

struct MonogramView: View {
    private struct CircledMonogram<Content: View>: View {
        var content: Content

        var body: some View {
            content
                .font(.system(.largeTitle, design: .rounded))
                .padding()
                .background(Color.yellow)
                .clipShape(Circle())
        }
    }

    let name: String

    func makeGenericMonogram() -> some View {
        CircledMonogram(content: Image(systemName: "person.fill"))
    }

    func makePreciseMonogram(for name: String) -> some View {
        CircledMonogram(content: Text(name))
    }

    func makeMonogram() -> some View {
        let formatter = PersonNameComponentsFormatter()

        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            let abbreviatedName = formatter.string(from: components)

            if abbreviatedName.count == 2 {
                return AnyView(makePreciseMonogram(for: abbreviatedName))
            }
        }

        return AnyView(makeGenericMonogram())
    }

    var body: some View {
        makeMonogram()
    }
}

struct ContentView: View {
    var body: some View {
        MonogramView(name: "Adele Laurie Blue Adkins")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
