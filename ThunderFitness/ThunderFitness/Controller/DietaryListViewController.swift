//
//  DietaryListViewController.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 05/12/2021.
//

import UIKit
import Firebase
class DietaryListViewController: UIViewController {
    
    
    @IBOutlet weak var noRecordLbl: UILabel!
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var Dietary = ""
    var selected = NSArray()
    var Dietaries = NSDictionary()
    
    var allTypes = NSArray()
    
    var selectedTypes = NSMutableArray()
    var userInfo = NSDictionary()
    
    var alreadySelected = NSArray()
    var key = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Dietary
        
        userInfo = UserDefaults.standard.value(forKey: "userinfo") as? NSDictionary ?? NSDictionary()
        
        
        Dietary = Dietary.replacingOccurrences(of: " ", with: "")
        noRecordLbl.isHidden = true
        dataTableView.isHidden = true
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        
        let already = userInfo["dietary"] as? String ?? ""
        alreadySelected = already.components(separatedBy: "@") as NSArray
        
        self.getWorkouts()
        self.getUserID()
        
        
    }
    
    func getWorkouts() -> Void {
        
        FirebaseTables.Dietary.observe(.value) { snapshot in
            
            if let id = snapshot.value as? NSDictionary {
                if id.count > 0 {
                    
                    self.Dietaries = id
                    self.selected = self.Dietaries[self.Dietary] as? NSArray ?? NSArray()
                    
                    for i in 0..<self.selected.count {
                        
                        if self.alreadySelected.contains(self.selected[i]) {
                            
                            self.selectedTypes.add(1)
                        }else{
                            
                            self.selectedTypes.add(0)
                        }
                    }
                    
                }else{
                    
                    self.Dietaries = NSDictionary()
                }
            }else{
                
                self.Dietaries = NSDictionary()
            }
            
            if self.Dietaries.count == 0 {
                
                self.indicatorView.isHidden = true
                self.noRecordLbl.isHidden = false
                self.dataTableView.isHidden = true
                
            }else{
                
                self.indicatorView.isHidden = true
                self.noRecordLbl.isHidden = true
                self.dataTableView.isHidden = false
                
            }
            
            self.dataTableView.reloadData()
            
        }
    }
    
    @objc func radionBtnClicked(sender: UIButton) -> Void {
        
        let tag = sender.tag
        if self.selectedTypes[tag] as! Int == 0 {
            
            self.selectedTypes.replaceObject(at: tag, with: 1)
            
        }else{
            
            self.selectedTypes.replaceObject(at: tag, with: 0)
        }
        
        self.updateData(key: key)
        dataTableView.reloadData()
    }
    
    func getUserID() -> Void {
        
        let email = userInfo["email"] as? String ?? ""
        let pass = userInfo["password"] as? String ?? ""
        
        FirebaseTables.User.observe(.value) { snapshot in
            
            for child in snapshot.children {
                
                let snap = child as! DataSnapshot
                let dic = snap.value as? NSDictionary ?? NSDictionary()
                
                let email1 = dic["email"] as? String ?? ""
                let pass1 = dic["password"] as? String ?? ""
                
                if email1.lowercased() == email.lowercased() && pass1 == pass {
                    
                    self.key = snap.key
                    return
                }
            }
        }
    }
    
    func updateData(key: String) -> Void {
        
        var text = ""
        for i in 0..<self.selectedTypes.count {
            
            if self.selectedTypes[i] as! Int == 1 {
                
                text = "\(text)@\(selected[i] as? String ?? "")"
            }
            
        }
        
        if text.count > 0 {
            
            text = String(text.dropFirst())
        }
        
        var trainer = ""
        
        if userInfo["trainer"] != nil {
            
            trainer = userInfo["trainer"] as! String
        }
        
        
        let params = ["name": userInfo["name"],
                      "email": userInfo["email"],
                      "password": userInfo["password"],
                      "program": userInfo["program"],
                      "metabolism": userInfo["metabolism"],
                      "gender": userInfo["gender"],
                      "age": userInfo["age"],
                      "height": userInfo["height"],
                      "weight": userInfo["weight"],
                      "alergies": userInfo["alergies"],
                      "injuries": userInfo["injuries"],
                      "dietary": text,
                      "trainer": trainer]
        
        self.showSpinner(onView: self.view)
        FirebaseTables.User.child(key).setValue(params){
            (error:Error?, ref:DatabaseReference) in
            if error == nil {
                
                self.removeSpinner()
                
                UserDefaults.standard.setValue(params, forKey: "userinfo")
                UserDefaults.standard.synchronize()
                
                self.view.makeToast("Diatery updated successfully!")
                
            } else {
                
                self.removeSpinner()
                self.view.makeToast("Something went wrong")
            }
        }
    }
    
}


extension DietaryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return selected.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("WorkOutListTableViewCell", owner: self, options: nil)?.first as! WorkOutListTableViewCell

        cell.selectionStyle = .none
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear

        cell.titleLbl.text = selected[indexPath.row] as? String ?? ""
        if selectedTypes[indexPath.row] as! Int == 0 {
            
            cell.radioBtn.setImage(UIImage(named: "checkboxUnChecked"), for: .normal)
            
        }else{
            
            cell.radioBtn.setImage(UIImage(named: "checkboxChecked"), for: .normal)
        }
        
        cell.radioBtn.isHidden = false
        cell.radioBtn.tag = indexPath.row
        cell.radioBtn.addTarget(self, action: #selector(radionBtnClicked(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
}

