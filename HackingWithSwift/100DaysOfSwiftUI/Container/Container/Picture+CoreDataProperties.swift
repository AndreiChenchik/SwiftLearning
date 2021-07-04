//
//  Picture+CoreDataProperties.swift
//  Container
//
//  Created by Andrei Chenchik on 24/6/21.
//
//

import Foundation
import CoreData
import UIKit

extension Picture {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Picture> {
        return NSFetchRequest<Picture>(entityName: "Picture")
    }
    
    @NSManaged public var fileName: String?
    @NSManaged public var title: String?
    @NSManaged public var coordinatesLatitude: Double
    @NSManaged public var coordinatesLongitude: Double
    
    var wrappedTitle: String {
        get { title ?? "Untitled" }
        set { title = newValue }
    }
    
    var wrappedImage: UIImage {
        image ?? UIImage(systemName: "questionmark")!
    }
    
    var image: UIImage? {
        if let fileName = fileName {
            let url = FileManager.default.getDocumentDirectory().appendingPathComponent(fileName)
            return UIImage(contentsOfFile: url.path)
        }
        
        return nil
    }
    
    func addPicture(_ image: UIImage) {
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            let fileName = UUID().uuidString
            let url = FileManager.default.getDocumentDirectory().appendingPathComponent(fileName)
            do {
                try jpegData.write(to: url, options: [.atomicWrite, .completeFileProtection])
                print("saved to \(url)")
                self.fileName = fileName
            } catch {
                fatalError("Unable to save image")
            }
        }
    }
}

extension Picture : Identifiable {
    
}
