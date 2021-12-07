//
//  DietartViewController.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 26/11/2021.
//

import UIKit

class DietaryViewController: UIViewController {
    
    @IBOutlet var dataTableView: UITableView!
    
    var diets = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "Diet"
        diets = ["Low Carb", "Weight Loss", "Weight Gain", "Vegan", "Diabetic"]
        
        dataTableView.backgroundColor = .clear
        dataTableView.delegate = self
        dataTableView.dataSource = self
        
    }
}

extension DietaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return diets.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("DietaryTableViewCell", owner: self, options: nil)?.first as! DietaryTableViewCell

        cell.selectionStyle = .none
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear

        GlobalMethods.CreateCardView(radius: 8, view: cell.contantView)
        cell.titleLbl.text = diets[indexPath.row] as? String ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "DietaryListViewController") as! DietaryListViewController
        let text = diets[indexPath.item] as? String ?? ""
        VC.Dietary = text
        self.navigationController!.pushViewController(VC, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
}
