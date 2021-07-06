//
//  CardView.swift
//  Flashzilla
//
//  Created by Andrei Chenchik on 6/7/21.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var cantBeRemoved = false
    var removal: (() -> Void)? = nil
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    @State private var secondRemoval = false
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fillCardColor(offset.width)
                )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 1.5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                    self.feedback.prepare()
                }
                
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        if self.offset.width < 0 {
                            self.feedback.notificationOccurred(.error)
                        }
                        
                        if self.offset.width < 0 && self.cantBeRemoved && !self.secondRemoval {
                            self.secondRemoval = true
                            self.offset = .zero
                            return
                        }
                        
                        self.removal?()
                    } else {
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
        .accessibility(addTraits: .isButton)
    }
    
    
}

extension RoundedRectangle {
    func fillCardColor(_ horizontalOffset: CGFloat) -> some View {
        let color: Color
        
        if horizontalOffset > 0 { color = .green }
        else if horizontalOffset < 0 { color = .red }
        else { color = .white }
        
        return self.fill(color)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
