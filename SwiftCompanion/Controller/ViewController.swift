//
//  ViewController.swift
//  SwiftCompanion
//
//  Created by ML on 31/01/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var form: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var markedButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let authorisation = Authorisation.shared
        Authorisation.getAccessToken { (success, access_token) in
            authorisation.access_token = access_token!
        }
        
        favoriteButton.layer.cornerRadius = 10
    
        form.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        errorLabel.text = ""
        button.isUserInteractionEnabled = true
        button.backgroundColor = UIColor.white
        form.text = ""
        markedButton.setTitle(Student.shared.marked1, for: .normal)
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        
        let authorisation = Authorisation.shared
        let login = form.text ?? ""
        if (login != ""){
            button.isUserInteractionEnabled = false
            button.backgroundColor = UIColor(red: 0.255, green: 0.255, blue: 0.255, alpha: 0.85)
            GetStudent.getStudentData(login: login, access_token: authorisation.access_token) {(success) in
                if success {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "displayDataSegue", sender: self)
                    }
                } else {
                    let authorisation = Authorisation.shared
                    if (authorisation.error_message != ""){
                        DispatchQueue.main.async {
                            let authorisation = Authorisation.shared
                            Authorisation.getAccessToken { (success, access_token) in
                                authorisation.access_token = access_token!
                            }
                            self.errorLabel.text = "Something wrong happened. Try again."
                            self.button.backgroundColor = UIColor.white
                            self.button.isUserInteractionEnabled = true
                        }
                    }
                    let student = Student.shared
                    if (student.errorMessage != ""){
                        DispatchQueue.main.async {
                            self.errorLabel.text = "Student couldn't be found with this login. Try again."
                            self.button.backgroundColor = UIColor.white
                            self.button.isUserInteractionEnabled = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.errorLabel.text = "Something wrong happened. Try again."
                            self.button.backgroundColor = UIColor.white
                            self.button.isUserInteractionEnabled = true
                        }
                    }
                }
            }
        } else {
            errorLabel.text = "You must write a login."
        }
       
    }
    
    @IBAction func addFavoriteButton(_ sender: Any) {
        Student.shared.marked1 = form.text ?? ""
        markedButton.setTitle(form.text ?? "", for: .normal)
    }
    
    @IBAction func markedButtonPressed(_ sender: Any) {
        form.text = markedButton.currentTitle
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        form.resignFirstResponder()
        return true
    }
}

