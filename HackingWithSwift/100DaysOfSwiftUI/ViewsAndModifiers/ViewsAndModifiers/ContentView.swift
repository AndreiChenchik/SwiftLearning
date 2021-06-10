//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Andrei Chenchik on 10/6/21.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows) { row in
                HStack {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
        
    }
}

struct ContentView: View {
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    var motto3: some View { Text("Draco dormiens") }
    @State private var isHello = true
    var body: some View {
        ScrollView {
            VStack {
                Button("hello/bye") {
                    self.isHello.toggle()
                }
                isHello ? Text("Hello, world!") : Text("Bye, world!")
                VStack {
                    Text("Hello, world!")
                    isHello ? Text("Hello, world!") : Text("Bye, world!")
                    Text("Hello, world!")
                        .font(.title)
                }
                .font(.largeTitle)
                .blur(radius: 5)
                VStack {
                    motto2
                    motto3
                }
                VStack(spacing: 10) {
                    Text("First")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .clipShape(Capsule())
                }
                VStack(spacing: 10) {
                    CapsuleText("First")
                    CapsuleText("Second")
                        .foregroundColor(.red)
                    Text("Hello there")
                        .modifier(Title())
                    Text("And there")
                        .titleStyle()
                    Color.blue
                        .frame(width: 400, height: 50)
                        .watermarked(with: "Property of chenchik")
                }
                GridStack(rows: 4, columns: 4) { row, col in
                    HStack {
                        Image(systemName: "\(row * 4 + col).circle")
                        Text("R\(row) C\(col)")
                    }
                }
                VStack {
                    Text("Test Foreground")
                        .foregroundColor(.blue)
                    Text("Challenge1")
                        .withLargeBlueFont()
                }
                .foregroundColor(.green)
            }
        }
    }
}

struct LargeBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func withLargeBlueFont() -> some View {
        self.modifier(LargeBlueFont())
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
