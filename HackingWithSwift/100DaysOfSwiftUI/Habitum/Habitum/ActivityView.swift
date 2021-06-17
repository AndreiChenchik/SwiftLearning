//
//  ActivityView.swift
//  Habitum
//
//  Created by Andrei Chenchik on 17/6/21.
//

import SwiftUI

struct ActivityView: View {
    @StateObject var habitum: Habitum
    
    let index: Int
        
    var body: some View {
        Form {
            Text(habitum.habits[index].description)
            Stepper("Completed \(habitum.habits[index].count) times") {
                habitum.habits[index].incrementCount()
                habitum.save()
            } onDecrement: {
                habitum.habits[index].decrementCount()
                habitum.save()
            }

        }
        .navigationTitle(habitum.habits[index].title)
        
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(habitum: Habitum(), index: 0)
    }
}
