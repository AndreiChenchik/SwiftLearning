//
//  UsersLoader.swift
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


class UsersLoader: ObservableObject {
    @Published var data = [User]()
        
    func decodeData(from data: Data) throws -> [jsonUser] {
        let decoder = JSONDecoder()
        let usersData = try decoder.decode([jsonUser].self, from: data)
        return usersData
    }
    
    
    func loadData(completionHandler: @escaping ([jsonUser]?, Error?) -> Void) {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(nil, UsersError.wrongResponseOnLoad)
                return
            }
            
            if let data = data {
                do {
                    let usersData = try self.decodeData(from: data)
                    completionHandler(usersData, nil)
                } catch {
                    completionHandler(nil, error)
                }
            }
        }.resume()
    }

}
