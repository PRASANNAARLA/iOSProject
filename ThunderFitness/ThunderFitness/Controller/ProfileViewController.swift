//
//  ProfileViewController.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 25/11/2021.
//

import UIKit
import Firebase


class ProfileViewController: UIViewController {
    
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var programTF: UITextField!
    @IBOutlet var metabolismTF: UITextField!
    
    @IBOutlet var dietaryLbl: UILabel!
    @IBOutlet var trainerLbl: UILabel!
    
    
    
    @IBOutlet var updateBtn: UIButton!
    
    
    var userInfo = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.isHidden = false
        
        self.setDesign()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.showData()
    }
    
    func setDesign() -> Void {
        
        updateBtn.layer.cornerRadius = cornerRadius
    }
    
    func showData() -> Void {
        
        userInfo = UserDefaults.standard.value(forKey: "userinfo") as? NSDictionary ?? NSDictionary()
        nameTF.text = userInfo["name"] as? String ?? ""
        programTF.text = userInfo["program"] as? String ?? ""
        metabolismTF.text = userInfo["metabolism"] as? String ?? ""
        
        var dietary = userInfo["dietary"] as? String ?? ""
        if dietary.count > 0 {
            
            dietary = dietary.replacingOccurrences(of: "@", with: ", ")
            dietaryLbl.text = dietary
        }
        
        let trainer = userInfo["trainer"] as? String ?? ""
        if trainer.count > 0 {
            
            trainerLbl.text = trainer
        }
        
    }
    
    @IBAction func updateBtnClicked(_ sender: Any) {
        
        if nameTF.isEmpty {
            
            self.view.makeToast("Please enter name")
            
        }else if programTF.isEmpty {
            
            self.view.makeToast("Please enter program")
            
        }else if metabolismTF.isEmpty {
            
            self.view.makeToast("Please enter metabolism")
            
        }else{
            
            let email = userInfo["email"] as? String ?? ""
            let pass = userInfo["password"] as? String ?? ""
            
            self.showSpinner(onView: self.view)
            FirebaseTables.User.observe(.value) { snapshot in
                
                for child in snapshot.children {
                    
                    let snap = child as! DataSnapshot
                    let dic = snap.value as? NSDictionary ?? NSDictionary()
                    
                    let email1 = dic["email"] as? String ?? ""
                    let pass1 = dic["password"] as? String ?? ""
                    
                    if email1.lowercased() == email.lowercased() && pass1 == pass {
                        
                        let key = snap.key
                        self.updateData(key: key)
                        return
                    }
                }
            }
        }
    }
    
    func updateData(key: String) -> Void {
        
        let params = ["name": nameTF.text!,
                      "email": userInfo["email"],
                      "password": userInfo["password"],
                      "program": programTF.text!,
                      "metabolism": metabolismTF.text!,
                      "gender": userInfo["gender"],
                      "age": userInfo["age"],
                      "height": userInfo["height"],
                      "weight": userInfo["weight"],
                      "alergies": userInfo["alergies"],
                      "injuries": userInfo["injuries"]]
        
        FirebaseTables.User.child(key).setValue(params){
            (error:Error?, ref:DatabaseReference) in
            if error == nil {
                
                self.removeSpinner()
                
                UserDefaults.standard.setValue(params, forKey: "userinfo")
                UserDefaults.standard.synchronize()
                
                self.view.makeToast("Profile updated successfully!")
                
            } else {
                
                self.removeSpinner()
                self.view.makeToast("Something went wrong")
            }
        }
        
    }
    
    @IBAction func logoutBtnClicked(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "userinfo")
        UserDefaults.standard.synchronize()
        
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController!.pushViewController(VC, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
}
