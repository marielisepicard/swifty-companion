//
//  Oauth2.swift
//  SwiftCompanion
//
//  Created by ML on 31/01/2022.
//

import Foundation

class OAuth2 {
    
//    private static let url = URL(string: "https://api.intra.42.fr/v2/oauth/token")!
//
//    static func getAccessToken(callback: @escaping (Bool, String?) -> Void) {
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        let body: [String: AnyHashable] = [
//            "grant_type": "client_credentials",
//            "client_id": "05e94cf05a711f8017ff5755a1204eaec22c7d215fa954d729574203c7162cf1",
//            "client_secret": "183b6aa69b7ac1a32917a167c763c090264ed56bb89218fd05ee60d06a78262e"
//        ]
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//
//        let task = URLSession.shared.dataTask(with: request) {data, _, error in
//            guard let data = data, error == nil else {
//                callback(false, nil)
//                return
//            }
//            do {
//                let response = try JSONDecoder().decode(Response.self, from: data)
//                callback(true, response.access_token)
//            } catch {
//                callback(false, nil)
//            }
//        }
//        task.resume()
//    }
}

//struct Response: Codable {
//    let access_token: String
//}
