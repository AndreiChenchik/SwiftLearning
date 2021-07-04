//
//  FileManager.swift
//  Container
//
//  Created by Andrei Chenchik on 3/7/21.
//

import Foundation

extension FileManager {
    func getDocumentDirectory() -> URL {
        let paths = self.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
