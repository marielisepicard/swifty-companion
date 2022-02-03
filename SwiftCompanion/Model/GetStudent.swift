//
//  GetStudent.swift
//  SwiftCompanion
//
//  Created by ML on 01/02/2022.
//

import Foundation

class GetStudent {

    static func getStudentData(login: String, access_token: String, callback: @escaping (Bool) -> Void) {
        
        let url = URL(string: "https://api.intra.42.fr/v2/users/" + login + "?access_token=" + access_token)!
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) {data, res, error in
            guard let data = data, error == nil else {
                callback(false)
                return
            }
            do {
                let httpResponse = res as? HTTPURLResponse
                if (httpResponse?.statusCode == 200){
                    let response = try JSONDecoder().decode(StudentResponse.self, from: data)
                    let student = Student.shared
                    student.login = response.login
                    student.email = response.email
                    student.wallet = response.wallet
                    student.image_url = response.image_url
                    student.cursus_users = response.cursus_users
                    student.projects_users = response.projects_users
                    student.errorMessage = ""
                    student.correction_point = response.correction_point
                    callback(true)
                } else if httpResponse?.statusCode == 401 {
                    let response = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    let authorisation = Authorisation.shared
                    authorisation.error_message = response.message
                    callback(false)
                } else if httpResponse?.statusCode == 404 {
                    let student = Student.shared
                    student.errorMessage = "No student found."
                    callback(false)
                }
            } catch {
                print(error)
                callback(false)
            }
        }
        task.resume()
    }
}

struct StudentResponse: Codable {
    let login: String
    let email: String
    let wallet: Int
    let image_url: String
    let cursus_users: [CursusUsers]
    let projects_users: [UserProjects]
    let correction_point: Int
}

struct CursusUsers: Codable {
    let skills: [Skills]
}

struct Skills: Codable {
    let name: String
    let level: Double
}

struct UserProjects: Codable {
    let final_mark: Int?
    let status: String
    let marked: Bool
    let validated: Bool?
    let project: ProjectDescription
}

struct ProjectDescription: Codable {
    let slug: String // delete slug
    let name: String
    let parent_id: Int?
}

struct ErrorResponse: Codable {
    let message: String
}
