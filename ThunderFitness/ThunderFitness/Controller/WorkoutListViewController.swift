//
//  WorkoutListViewController.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 05/12/2021.
//

import UIKit

class WorkoutListViewController: UIViewController {
    
    @IBOutlet weak var noRecordLbl: UILabel!
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var workout = ""
    var selected = NSArray()
    var workouts = NSDictionary()
    
    var allTypes = NSArray()
    
    var selectedTypes = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = workout
        
        workout = workout.lowercased()
        noRecordLbl.isHidden = true
        dataTableView.isHidden = true
        indicatorView.isHidden = false
        indicatorView.startAnimating()
        
        dataTableView.delegate = self
        dataTableView.dataSource = self
        
        self.getWorkouts()
    }
    
    func getWorkouts() -> Void {
        
        FirebaseTables.Workouts.observe(.value) { snapshot in
            
            if let id = snapshot.value as? NSDictionary {
                if id.count > 0 {
                    
                    self.workouts = id
                    self.selected = self.workouts[self.workout] as? NSArray ?? NSArray()
                    
                    for _ in 0..<self.selected.count {
                        
                        self.selectedTypes.add(0)
                        
                    }
                    
                }else{
                    
                    self.workouts = NSDictionary()
                }
            }else{
                
                self.workouts = NSDictionary()
            }
            
            if self.workouts.count == 0 {
                
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
        
        dataTableView.reloadData()
    }
    
}


extension WorkoutListViewController: UITableViewDelegate, UITableViewDataSource {
    
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

        let dict = selected[indexPath.row] as? NSDictionary ?? NSDictionary()
        cell.titleLbl.text = dict["name"] as? String ?? ""
        
        if selectedTypes[indexPath.row] as! Int == 0 {
            
            cell.radioBtn.setImage(UIImage(named: "checkboxUnChecked"), for: .normal)
            
        }else{
            
            cell.radioBtn.setImage(UIImage(named: "checkboxChecked"), for: .normal)
        }
        
        cell.radioBtn.isHidden = true
        cell.radioBtn.tag = indexPath.row
        cell.radioBtn.addTarget(self, action: #selector(radionBtnClicked(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "WorkoutDetailsViewController") as! WorkoutDetailsViewController
        let dict = self.selected[indexPath.row] as? NSDictionary ?? NSDictionary()
        VC.workout = dict
        VC.navigationItem.title = dict["name"] as? String ?? ""
        self.navigationController!.pushViewController(VC, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
}
