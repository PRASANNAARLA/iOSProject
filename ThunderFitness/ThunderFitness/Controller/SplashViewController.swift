//
//  SplashViewController.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 25/11/2021.
//

import UIKit

class SplashViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        perform(#selector(MoveToHome), with: nil, afterDelay: 4.0)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func MoveToHome() {
        
        let userInfo = UserDefaults.standard.value(forKey: "userinfo") as? NSDictionary ?? NSDictionary()
        if userInfo.count == 0 {
            
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController!.pushViewController(VC, animated: true)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            
        }else{
            
            let VC = self.storyboard!.instantiateViewController(withIdentifier: "myTabBar") as! UITabBarController
            self.navigationController!.pushViewController(VC, animated: true)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            
        }
    }
}
