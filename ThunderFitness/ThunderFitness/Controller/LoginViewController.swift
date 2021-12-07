//
//  LoginViewController.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 25/11/2021.
//

import UIKit
import Firebase

public var cornerRadius: CGFloat = 10.0

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    
    @IBOutlet var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDesign()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setDesign() -> Void {
        
        signInBtn.layer.cornerRadius = cornerRadius
        
    }
    
    @IBAction func signInBtnClicked(_ sender: Any) {
        
        self.view.endEditing(true)
        if emailTF.isEmpty {
            
            self.view.makeToast("Please enter email")
            
        }else if passwordTF.isEmpty {
            
            self.view.makeToast("Please enter password")
            
        }else{
            
            self.showSpinner(onView: self.view)
            FirebaseTables.User.observe(.value) { snapshot in
                if snapshot.childrenCount == 0 {
                    
                    self.removeSpinner()
                    self.view.makeToast("Invalid email or password")
                    
                }else{
                    
                    var i = 0
                    
                    for child in snapshot.children {
                        
                        i += 1
                        let snap = child as! DataSnapshot
                        let dic = snap.value as? NSDictionary ?? NSDictionary()
                        
                        let email = dic["email"] as? String ?? ""
                        let pass = dic["password"] as? String ?? ""
                        
                        if email.lowercased() == self.emailTF.text?.lowercased() && pass == self.passwordTF.text!{
                            
                            self.removeSpinner()
                            self.moveToHome(dict: dic)
                            return
                            
                        }
                        
                        if i == snapshot.childrenCount {
                            
                            self.removeSpinner()
                            self.view.makeToast("Invalid email or password")
                        }
                    }
                }
            }
        }
    }
    
    func moveToHome(dict: NSDictionary) -> Void {
        
        UserDefaults.standard.setValue(dict, forKey: "userinfo")
        UserDefaults.standard.synchronize()
        
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "myTabBar") as! UITabBarController
        self.navigationController!.pushViewController(VC, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    @IBAction func registerBtnClicked(_ sender: Any) {
        
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController!.pushViewController(VC, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
}



extension NSMutableAttributedString {

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }

}
