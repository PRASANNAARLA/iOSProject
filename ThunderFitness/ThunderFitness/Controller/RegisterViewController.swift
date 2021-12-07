//
//  RegisterViewController.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 25/11/2021.
//

import UIKit
import Toast
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var confirmPasswordTF: UITextField!
    
    @IBOutlet var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDesign()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setDesign() -> Void {
        
        registerBtn.layer.cornerRadius = cornerRadius
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        
        if nameTF.isEmpty {
            
            self.view.makeToast("Please enter full name")
            
        }else if emailTF.isEmpty {
            
            self.view.makeToast("Please enter email")
            
        }else if passwordTF.isEmpty {
            
            self.view.makeToast("Please enter password")
            
        }else if confirmPasswordTF.isEmpty {
            
            self.view.makeToast("Please enter confirm password")
            
        }else{
            
            if !GlobalMethods.validateEmail(enteredEmail: emailTF.text!) {
                
                self.view.makeToast("Please enter valid email")
            }else {
                
                if passwordTF.text! != confirmPasswordTF.text! {
                    
                    self.view.makeToast("Password and Confirm Password must be same")
                    
                }else{
                    
                    self.showSpinner(onView: self.view)
                    self.checkEmailExists()
                }
            }
        }
    }
    
    func checkEmailExists() -> Void {
        
        FirebaseTables.User.observe(.value) { snapshot in
            
            if snapshot.childrenCount == 0 {
                
                self.addUser()
                return
                
            }else {
                
                var i = 0
                for child in snapshot.children {
                    
                    i += 1
                    let snap = child as! DataSnapshot
                    let dic = snap.value as? NSDictionary ?? NSDictionary()
                    
                    let email = dic["email"] as? String ?? ""
                    if email.lowercased() == self.emailTF.text?.lowercased() {
                        
                        self.removeSpinner()
                        if snapshot.childrenCount > 1 {
                            
                            self.view.makeToast("Email already exists")
                        }
                        return
                    }
                    
                    if i == snapshot.childrenCount {
                        
                        self.addUser()
                    }
                }
            }
        }
    }
    
    
    @objc func addUser() -> Void {
        
        let params = ["name": nameTF.text!,
                      "email": emailTF.text!,
                      "password": passwordTF.text!,
                      "program": "",
                      "metabolism": "",
                      "gender": "",
                      "age": "",
                      "height": "",
                      "weight": "",
                      "alergies": "",
                      "injuries": "",
                      "dietary": "",
                      "trainer": ""]
        
        FirebaseTables.User.childByAutoId().setValue(params){
            (error:Error?, ref:DatabaseReference) in
            if error == nil {
                
                self.removeSpinner()
                self.moveToHome(dic: params as NSDictionary)
                
            } else {
                
                self.removeSpinner()
                self.view.makeToast("Something went wrong")
            }
        }
    }
    
    func moveToHome(dic: NSDictionary) -> Void {
        
        UserDefaults.standard.setValue(dic, forKey: "userinfo")
        UserDefaults.standard.synchronize()
        
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "myTabBar") as! UITabBarController
        self.navigationController!.pushViewController(VC, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
}


