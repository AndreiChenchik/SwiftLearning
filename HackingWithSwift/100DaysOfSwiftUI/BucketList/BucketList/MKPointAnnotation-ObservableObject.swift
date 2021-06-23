//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Andrei Chenchik on 23/6/21.
//

import Foundation
import MapKit


extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? ""
        }
        
        set {
            title = newValue
        }
    }
    
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? ""
        }
        
        set {
            subtitle = newValue
        }
    }
    
}
