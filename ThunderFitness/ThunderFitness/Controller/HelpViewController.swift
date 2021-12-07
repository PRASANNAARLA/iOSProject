//
//  HelpViewController.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 25/11/2021.
//

import UIKit
import Firebase


class HelpViewController: UIViewController {
    
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var descriptionLbl: UILabel!
    
    
    @IBOutlet var emailView: UIView!
    @IBOutlet var emailLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Help"
        self.navigationController?.navigationBar.isHidden = false
        
        descriptionView.isHidden = true
        emailView.isHidden = true
        
        indicatorView.startAnimating()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FirebaseTables.Help.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let id = snapshot.value as? NSDictionary {
                print("The value from the database: \(id)")
            
                if id.count > 0 {
                    
                    let email = id["email"] as? String ?? ""
                    let desc = id["description"] as? String ?? ""
                    
                    self.indicatorView.isHidden = true
                    
                    if email != "" {
                        
                        self.emailView.isHidden = false
                        self.emailLbl.text = email
                    }
                    
                    if desc != "" {
                        
                        self.descriptionView.isHidden = false
                        self.descriptionLbl.text = desc
                    }
                    
                }else{
                    
                    self.descriptionView.isHidden = true
                    self.emailView.isHidden = true
                }
            }else{
                self.descriptionView.isHidden = true
                self.emailView.isHidden = true
                
            }
        })
    }
}
