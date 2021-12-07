//
//  PersonalizationViewController.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 26/11/2021.
//

import UIKit
import Firebase


class PersonalizationViewController: UIViewController {
    
    @IBOutlet var genderTF: UITextField!
    @IBOutlet var ageTF: UITextField!
    @IBOutlet var heightTF: UITextField!
    @IBOutlet var weightTF: UITextField!
    @IBOutlet var allergiesTF: UITextField!
    @IBOutlet var injuriesTF: UITextField!
    
    
    @IBOutlet weak var updateBtn: UIButton!
    
    var userInfo = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "Personalization"
        
        updateBtn.layer.cornerRadius = cornerRadius
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setData()
    }
    
    
    func setData() -> Void {
        
        userInfo = UserDefaults.standard.value(forKey: "userinfo") as? NSDictionary ?? NSDictionary()
        genderTF.text = userInfo["gender"] as? String ?? ""
        ageTF.text = userInfo["age"] as? String ?? ""
        heightTF.text = userInfo["height"] as? String ?? ""
        weightTF.text = userInfo["weight"] as? String ?? ""
        allergiesTF.text = userInfo["alergies"] as? String ?? ""
        injuriesTF.text = userInfo["injuries"] as? String ?? ""
        
        updateBtn.setTitle("Update", for: .normal)
        if genderTF.isEmpty && ageTF.isEmpty && heightTF.isEmpty && weightTF.isEmpty && allergiesTF.isEmpty && injuriesTF.isEmpty {
            
            updateBtn.setTitle("Add", for: .normal)
        }
        
    }
    
    
    @IBAction func updateBtnClicked(_ sender: Any) {
        
        if genderTF.isEmpty {
            
            self.view.makeToast("Please enter gender")
            
        }else if ageTF.isEmpty {
            
            self.view.makeToast("Please enter age")
            
        }else if heightTF.isEmpty {
            
            self.view.makeToast("Please enter height")
            
        }else if weightTF.isEmpty {
            
            self.view.makeToast("Please enter weight")
            
        }else if allergiesTF.isEmpty {
            
            self.view.makeToast("Please enter allergies")
            
        }else if injuriesTF.isEmpty {
            
            self.view.makeToast("Please enter injuries")
            
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
        
        let dietary = userInfo["dietary"] as? String ?? ""
        let trainer = userInfo["trainer"] as? String ?? ""
        
        
        let params = ["name": userInfo["name"],
                      "email": userInfo["email"],
                      "password": userInfo["password"],
                      "program": userInfo["program"],
                      "metabolism": userInfo["metabolism"],
                      "gender": genderTF.text!,
                      "age": ageTF.text!,
                      "height": heightTF.text!,
                      "weight": weightTF.text!,
                      "alergies": allergiesTF.text!,
                      "injuries": injuriesTF.text!,
                      "dietary": dietary,
                      "trainer": trainer]
        
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
    
}
