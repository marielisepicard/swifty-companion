//
//  DisplayData.swift
//  SwiftCompanion
//
//  Created by ML on 31/01/2022.
//

import UIKit

class DisplayData: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var projectsTableView: UITableView!
    @IBOutlet weak var skillsTableView: UITableView!
    @IBOutlet weak var correctionPointsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let student = Student.shared
        emailLabel.text = student.email
        loginLabel.text = student.login
        walletLabel.text = "Wallet: " + String(student.wallet)
        correctionPointsLabel.text = "Correction points: " + String(student.correction_point)
        let url = URL(string: student.image_url)
        let data = try? Data(contentsOf: url!)
        studentImage.image = UIImage(data: data!)
        
        studentImage.layer.masksToBounds = true
        studentImage.layer.borderColor = UIColor.white.cgColor
        studentImage.layer.cornerRadius = 75
   
        projectsTableView.delegate = self
        skillsTableView.delegate = self
        projectsTableView.dataSource = self
        skillsTableView.dataSource = self
        student.takeSortedProject = false
        
        student.cleanProjects(initialProjectList: student.projects_users)
        student.sortedProjects(initialProjects: student.updated_projects)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        switch tableView {
        case projectsTableView:
            numberOfRows = Student.shared.updated_projects.count
        case skillsTableView:
            if Student.shared.cursus_users.count > 0 {
                numberOfRows = Student.shared.cursus_users[Student.shared.cursus_users.count - 1].skills.count
            } else {
                numberOfRows = 0
            }
        default:
            numberOfRows = 0
            print("Something wrong happened in numberOfRowsInSection function")
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        var cell = UITableViewCell()
        switch tableView {
        case projectsTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath)
            var project = Student.shared.updated_projects[indexPath.row]
            if (Student.shared.takeSortedProject == true){
                project = Student.shared.sortedProject[indexPath.row]
            }
            cell.textLabel?.text = project.project.slug
            if project.status == "in_progress" || project.status == "searching_a_group" {
                cell.detailTextLabel?.text = "In progress..."
                cell.detailTextLabel?.textColor = UIColor.orange
            } else {
                if project.final_mark != nil && project.final_mark! > 50 {
                    cell.detailTextLabel?.text = String(project.final_mark!)
                    cell.detailTextLabel?.textColor = UIColor.green
                } else if project.final_mark != nil && project.final_mark! <= 50 {
                    cell.detailTextLabel?.text = String(project.final_mark!)
                    cell.detailTextLabel?.textColor = UIColor.red
                } else {
                    cell.detailTextLabel?.text = String(0)
                    cell.detailTextLabel?.textColor = UIColor.red
                }
            }
            
        case skillsTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: "SkillCell", for: indexPath)
            let skill = Student.shared.cursus_users[Student.shared.cursus_users.count - 1].skills[indexPath.row]
                cell.textLabel?.text = skill.name
            cell.detailTextLabel?.text = String(format: "%.2f", skill.level) + "     " + String(format: "%.0f", skill.level / 21 * 100) + "%"
        default:
            print("Something wrong happened in cellForRowAt function")
        }
        return cell
    }
    
    @IBAction func sortButtonPressed(_ sender: Any) {
        if Student.shared.takeSortedProject == true {
            sortButton.backgroundColor = UIColor.white
            Student.shared.takeSortedProject = false
        } else {
            sortButton.backgroundColor = UIColor(red: 0.255, green: 0.255, blue: 0.255, alpha: 0.85)
            Student.shared.takeSortedProject = true
        }
        projectsTableView.reloadData()
    }

}
