//
//  TrainersViewController.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 26/11/2021.
//

import UIKit
import Firebase

class TrainersViewController: UIViewController {
    
    @IBOutlet var noRecordLbl: UILabel!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var dataTableView: UITableView!
    
    var trainers = NSArray()
    var selectedTrainer = ""
    
    var userInfo = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "Trainers"
        
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        noRecordLbl.isHidden = true
        dataTableView.isHidden = true
        
        dataTableView.backgroundColor = .clear
        dataTableView.delegate = self
        dataTableView.dataSource = self
        
        userInfo = UserDefaults.standard.value(forKey: "userinfo") as? NSDictionary ?? NSDictionary()
        
        selectedTrainer = userInfo["trainer"] as? String ?? ""
        self.getTrainers()
    }
    
    
    
    func getTrainers() -> Void {
        
        FirebaseTables.Trainers.observe(.value) { snapshot in
            
            if let id = snapshot.value as? NSArray {
                if id.count > 0 {
                    
                    self.trainers = id
                }else{
                    
                    self.trainers = NSArray()
                }
            }else{
                
                self.trainers = NSArray()
            }
            
            if self.trainers.count == 0 {
                
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
    
    @objc func defaultBtnClciked(sender: UIButton) -> Void {
        
        let dict = trainers[sender.tag] as? NSDictionary ?? NSDictionary()
        selectedTrainer = dict["name"] as? String ?? ""
        
        self.getID()
        
    }
    
    func getID() -> Void {
        
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
    
    func updateData(key: String) -> Void {
        
        let dietary = userInfo["dietary"] as? String ?? ""
        let trainer = selectedTrainer
        
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
                      "dietary": dietary,
                      "trainer": trainer]
        
        FirebaseTables.User.child(key).setValue(params){
            (error:Error?, ref:DatabaseReference) in
            if error == nil {
                
                self.removeSpinner()
                
                UserDefaults.standard.setValue(params, forKey: "userinfo")
                UserDefaults.standard.synchronize()
                
                self.view.makeToast("Trainer updated successfully!")
                self.dataTableView.reloadData()
                
            } else {
                
                self.removeSpinner()
                self.view.makeToast("Something went wrong")
            }
        }
    }
}

extension TrainersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return trainers.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("TrainerTableViewCell", owner: self, options: nil)?.first as! TrainerTableViewCell

        cell.selectionStyle = .none
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear

        GlobalMethods.CreateCardView(radius: 8, view: cell.contantView)
        let dict = trainers[indexPath.row] as? NSDictionary ?? NSDictionary()
        
        let urlString = dict.value(forKey: "image") as? String ?? ""
        if urlString != "" {
            
            let Ref = Storage.storage().reference(forURL: urlString)

            Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if error != nil {
                    print("Error: Image could not download!")
                } else {
                    cell.imgView.image = UIImage(data: data!)
                }
            }
        }
        
        let name = dict["name"] as? String ?? ""
        cell.nameLbl.text = name
        cell.ageLbl.text = "Age: \(dict["age"] as? String ?? "")"
        cell.expierenceLbl.text = "Expierence: \(dict["expierence"] as? String ?? "")"
        
        cell.imgView.layer.cornerRadius = cell.imgView.frame.size.height/2
        cell.imgView.clipsToBounds = true
        
        cell.radioBtn.setImage(UIImage(named: "RadioUnChecked"), for: .normal)
        if name == selectedTrainer {
            
            cell.radioBtn.setImage(UIImage(named: "RadioChecked"), for: .normal)
            
        }
        cell.radioBtn.tag = indexPath.row
        cell.radioBtn.addTarget(self, action: #selector(defaultBtnClciked(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}
