//
//  ContentView.swift
//  BucketList
//
//  Created by Andrei Chenchik on 22/6/21.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var isUnlocked = false
    
    @State private var showingAuthFailureError = false
    @State private var alertErrorTitle = ""
    @State private var alertErrorMessage = ""
    var body: some View {
        if self.isUnlocked {
            MainView()
        } else {
            Button("Unlock Places") {
                self.authenticate()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .alert(isPresented: $showingAuthFailureError) {
                Alert(title: Text(alertErrorTitle), message: Text(alertErrorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            // perform authentication
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication completed
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        alertErrorTitle = "Can't authenticate you"
                        alertErrorMessage = "Please try again"
                        showingAuthFailureError = true
                        
                    }
                }
            }
        } else {
            alertErrorTitle = "Sorry…"
            alertErrorMessage = "You won't be able to use this app on your device"
            showingAuthFailureError = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
