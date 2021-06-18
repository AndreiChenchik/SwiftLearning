//
//  FilteredListView.swift
//  CoreDataProject
//
//  Created by Andrei Chenchik on 18/6/21.
//

import SwiftUI
import CoreData

enum PredicateKey: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
    case endsWith = "ENDSWITH"
    case like = "LIKE"
    case matches = "MATCHES"
}

struct FilteredListView<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var list: FetchedResults<T> { fetchRequest.wrappedValue }
    
    let content: (T) -> Content
    
    init(filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor] = [], predicateKey: PredicateKey = .beginsWith, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicateKey.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
    
    var body: some View {
        List(list, id: \.self) { item in
            self.content(item)
        }
    }
}

