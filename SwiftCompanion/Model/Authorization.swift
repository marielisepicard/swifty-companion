//
//  Authorization.swift
//  SwiftCompanion
//
//  Created by ML on 01/02/2022.
//

import Foundation

class Authorisation {
    
    static var shared = Authorisation()
    
    private init(){}
    
    var access_token: String = ""
    var error_message: String = ""
    private static let url = URL(string: "https://api.intra.42.fr/v2/oauth/token")!
    
    static func getAccessToken(callback: @escaping (Bool, String?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "grant_type": "client_credentials",
            "client_id": Secret.shared.client_id,
            "client_secret": Secret.shared.client_secret
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data, error == nil else {
                callback(false, nil)
                return
            }
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                callback(true, response.access_token)
            } catch {
                callback(false, nil)
            }
        }
        task.resume()
    }
}

struct Response: Codable {
    let access_token: String
}
