//
//  Student.swift
//  SwiftCompanion
//
//  Created by ML on 01/02/2022.
//

import Foundation

class Student {
    
    static var shared = Student()
    private init(){}
    
    var login = ""
    var email = ""
    var wallet = -1
    var image_url = ""
    var errorMessage = ""
    var correction_point = -1
    var updated_projects: [UserProjects] = []
    
    var cursus_users: [CursusUsers] = []
    var projects_users: [UserProjects] = []
    var takeSortedProject: Bool = false
    
    var sortedProject: [UserProjects] = []
    
    var marked1: String = ""
    
    func cleanProjects(initialProjectList: [UserProjects]){
        var newProjectList: [UserProjects] = []
        var i = 0
        while (i < initialProjectList.count){
            
            if (initialProjectList[i].project.parent_id == nil) {
                newProjectList.insert(initialProjectList[i], at: 0)
            }
            i = i+1
        }
        updated_projects = newProjectList
    }
    
    func sortedProjects(initialProjects: [UserProjects]){
        
        var sortedProjects: [UserProjects] = []
        
        var i = 0
        while (i < initialProjects.count){
            var j = 0
            var mark1 = initialProjects[i].final_mark ?? 0
            var mark2: Int
            if (sortedProjects.count > 0){
                mark2 = sortedProjects[0].final_mark ?? 0
            } else {
                mark2 = 0
            }
            while (j < sortedProjects.count && mark1 < mark2){
                j = j + 1
                mark1 = initialProjects[i].final_mark ?? 0
                if (sortedProjects.count > j){
                    mark2 = sortedProjects[j].final_mark ?? 0
                } else {
                    mark2 = 0
                }
            }
            sortedProjects.insert(initialProjects[i], at: j)
            i = i + 1
        }
        sortedProject = sortedProjects
    }
}
