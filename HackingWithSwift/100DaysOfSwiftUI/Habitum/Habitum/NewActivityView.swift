//
//  NewActivityView.swift
//  Habitum
//
//  Created by Andrei Chenchik on 17/6/21.
//

import SwiftUI

struct NewActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var habitum: Habitum
    
    @State private var activityTitle = ""
    @State private var activityDescription = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Habit Title", text: $activityTitle)
                TextField("Habit Description", text: $activityDescription)
                Button("Save new habit") {
                    let habit = Habit(title: activityTitle, description: activityDescription)
                    habitum.habits.append(habit)
                    habitum.save()
                    presentationMode.wrappedValue.dismiss()
                }
            }.navigationBarTitle("Create new habit", displayMode: .inline)
        }
    }
}

struct NewActivityView_Previews: PreviewProvider {
    static var previews: some View {
        NewActivityView(habitum: Habitum())
    }
}
