//
//  ContentView.swift
//  Drawing
//
//  Created by Andrei Chenchik on 15/6/21.
//

import SwiftUI

struct TriangleAbsolute: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 200, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 300))
        path.addLine(to: CGPoint(x: 300, y: 300))
        path.addLine(to: CGPoint(x: 200, y: 100))
        
        return path
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct Flower: Shape {
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: CGFloat(0), to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
            
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        
        return arc
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(
                                    gradient: Gradient(colors: [
                                                        self.color(for: value, brightness: 1),
                                                        self.color(for: value, brightness: 0.5)]
                                    ),
                                    startPoint: .top,
                                    endPoint: .bottom),
                                  lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Trapezoid: Shape {
    var insetAmount: CGFloat
    
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}


struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        
        set {
            self.rows = Int(newValue.first)
            self.columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)
        
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    
                    path.addRect(rect)
                }
            }
        }
        
        return path
    }
}

struct Spirograph: Shape {
    var animatableData: CGFloat {
        get { amount }
        set { self.amount = newValue }
    }
    
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    var amount: CGFloat
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = CGFloat(self.outerRadius)
        let innerRadius = CGFloat(self.innerRadius)
        let distance = CGFloat(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * CGFloat.pi * outerRadius / CGFloat(divisor)) * amount
        
        var path = Path()
        
        for theta in stride(from: CGFloat(0), through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width / 2
            y += rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        return path
    }
    
}


struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    @State private var colorCycle = 0.0
    
    @State private var amount: CGFloat = 0.0
    
    @State private var insetAmount: CGFloat = 50
    
    @State private var rows = 4
    @State private var columns = 4
    
    @State private var innerRadius = 125.0
        @State private var outerRadius = 75.0
        @State private var distance = 25.0
        @State private var amountSG: CGFloat = 1.0
        @State private var hue = 0.6
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 20) {
                    Group {
                        Text("Inner radius: \(Int(innerRadius))")
                        Slider(value: $innerRadius, in: 10...150, step: 1)
                            .padding([.horizontal])

                        Text("Outer radius: \(Int(outerRadius))")
                        Slider(value: $outerRadius, in: 10...150, step: 1)
                            .padding([.horizontal])

                        Text("Distance: \(Int(distance))")
                        Slider(value: $distance, in: 1...150, step: 1)
                            .padding([.horizontal])

                        Text("Amount: \(amount, specifier: "%.2f")")
                        Slider(value: $amountSG.animation(Animation.easeInOut(duration: 3)))
                            .padding([.horizontal])

                        Text("Color")
                        Slider(value: $hue)
                            .padding(.horizontal)
                    }
                    
                    Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amountSG)
                        .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                        .frame(width: geometry.size.width, height: geometry.size.width)
                    
                    Checkerboard(rows: rows, columns: columns)
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .onTapGesture {
                            withAnimation(.linear(duration: 3)) {
                                self.rows = Int.random(in: 4...8)
                                self.columns = Int.random(in: 4...16)
                            }
                        }
                    
                    Trapezoid(insetAmount: insetAmount)
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .onTapGesture {
                            withAnimation {
                                self.insetAmount = CGFloat.random(in: geometry.size.width / 5...geometry.size.width / 2)
                            }
                        }
                    Group {
                        Image("barcelona")
                            .resizable()
                            .scaledToFit()
                            .saturation(Double(amount))
                            .blur(radius: (1 - amount) * 20)
                        
                        Slider(value: $amount)
                            .padding()
                        ZStack {
                            Circle()
                                .fill(Color(red: 1, green: 0, blue: 0))
                                .frame(width: 200 * amount)
                                .offset(x: -50, y: -80)
                                .blendMode(.screen)
                            Circle()
                                .fill(Color(red: 0, green: 1, blue: 0))
                                .frame(width: 200 * amount)
                                .offset(x: 50, y: -80)
                                .blendMode(.screen)
                            Circle()
                                .fill(Color(red: 0, green: 0, blue: 1))
                                .frame(width: 200 * amount)
                                .blendMode(.screen)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        
                        
                        
                        Image("barcelona")
                            .resizable()
                            .scaledToFit()
                            .colorMultiply(.red)
                        
                        ZStack {
                            Image("barcelona")
                                .resizable()
                                .scaledToFit()
                            
                            Rectangle()
                                .fill(Color.red)
                                .blendMode(.multiply)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .clipped()
                        
                        ColorCyclingCircle(amount: self.colorCycle)
                            .frame(width: geometry.size.width, height: geometry.size.width)
                        Slider(value: $colorCycle)
                        Capsule()
                            .strokeBorder(ImagePaint(image: Image("barcelona"), sourceRect: CGRect(x: 0, y: 0.08, width: 1, height: 0.5),scale: 0.05), lineWidth: 10)
                            .frame(width: geometry.size.width, height: geometry.size.width / 2)
                    }
                    Group {
                        Text("Hello World")
                            .frame(width: geometry.size.width, height: geometry.size.width)
                            .border(ImagePaint(image: Image("barcelona"), sourceRect: CGRect(x: 0, y: 0.08, width: 1, height: 0.5),scale: 0.2), width: 30)
                        Text("Hello World")
                            .frame(width: geometry.size.width, height: geometry.size.width)
                            .border(ImagePaint(image: Image("barcelona"), scale: 0.01), width: 30)
                        Text("Hello World")
                            .frame(width: geometry.size.width, height: geometry.size.width)
                            .border(Color.red, width: 30)
                        Text("Hello World")
                            .frame(width: geometry.size.width, height: geometry.size.width)
                            .background(Image("barcelona"))
                            .clipped()
                        Text("Hello World")
                            .frame(width: geometry.size.width, height: geometry.size.width)
                            .background(Color.red)
                        Text("petalOffset")
                        Slider(value: $petalOffset, in: -40...40)
                            .padding([.horizontal])
                        Text("petalWidth")
                        Slider(value: $petalWidth, in: 0...100)
                            .padding([.horizontal])
                        
                    }
                    Group {
                        Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                            .fill(Color.green, style: FillStyle(eoFill: true))
                            .frame(width: geometry.size.width, height: geometry.size.width)
                        Arc(startAngle: .degrees(-90), endAngle: .degrees(90), clockwise: true)
                            .strokeBorder(Color.purple, lineWidth: 40)
                            .frame(width: geometry.size.width, height: geometry.size.width)
                        Circle()
                            .strokeBorder(Color.blue, lineWidth: 40)
                            .frame(width: geometry.size.width, height: geometry.size.width)
                        Circle()
                            .stroke(Color.blue, lineWidth: 40)
                            .frame(width: geometry.size.width, height: geometry.size.width)
                        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
                            .stroke(Color.blue, lineWidth: 10)
                            .frame(width: 300, height: 300)
                        Triangle()
                            .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                            .frame(width: 300, height: 300)
                        Triangle()
                            .fill(Color.red)
                            .frame(width: 300, height: 300)
                        TriangleAbsolute()
                            .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                            .frame(width: 300, height: 300)
                        TriangleAbsolute()
                            .stroke(Color.blue, lineWidth: 10)
                            .frame(width: 300, height: 300)
                    }
                }
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
