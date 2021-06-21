//
//  Users.swift
//  FriendFace
//
//  Created by Andrei Chenchik on 21/6/21.
//

import Foundation

enum UsersError: Error, LocalizedError {
    case wrongResponseOnLoad
    
    public var errorDescription: String? {
        switch self {
        case .wrongResponseOnLoad:
            return NSLocalizedString(
                "Server send back wrong response code.",
                comment: "Invalid Response Code"
            )
        }
    }
}


class Users: ObservableObject {
    @Published var data = [User]()
    
    var activeUsers: [User] { data.filter { $0.isActive } }
    
    func decodeData(from data: Data) throws {
        let decoder = JSONDecoder()
        let newData = try decoder.decode([User].self, from: data)
        
        DispatchQueue.main.async {
            self.data = newData
        }
    }
    
    
    func loadData(errorHandler: @escaping (Error) -> Void) {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                errorHandler(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                errorHandler(UsersError.wrongResponseOnLoad)
                return
            }
            
            if let data = data {
                do {
                    try self.decodeData(from: data)
                } catch {
                    errorHandler(error)
                }
            }
        }.resume()
    }

}
