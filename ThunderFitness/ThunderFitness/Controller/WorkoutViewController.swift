//
//  WorkoutViewController.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 25/11/2021.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    
    @IBOutlet var dataCollectionView: UICollectionView!
    
    var workouts = NSArray()
    var workout = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationItem.title = "Workouts"
        self.navigationController?.navigationBar.isHidden = false
                
        workouts = ["Chest", "Shoulder", "Arms", "Abdomen", "Legs", "Cardio"]
        
        dataCollectionView.backgroundColor = .clear
        dataCollectionView.delegate = self
        dataCollectionView.dataSource = self
        dataCollectionView.register(UINib(nibName: "WorkoutCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "WorkoutCollectionViewCell")
        
    }
}


extension WorkoutViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 48, left: 24, bottom: 32, right:24)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return workouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        var width = 0
        let view = self.view.frame.size.width / 2
        
        width = Int(view)
        width -= 40
        
        return CGSize(width: width, height: width + 24)
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : WorkoutCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "WorkoutCollectionViewCell", for: indexPath) as! WorkoutCollectionViewCell
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        GlobalMethods.CreateCardView(radius: 10, view: cell.contantView)
        
        let text = workouts[indexPath.row] as? String ?? ""
        
        cell.imgView.image = UIImage(named: text)
        cell.titleLbl.text = text.uppercased()
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "WorkoutListViewController") as! WorkoutListViewController
        let workout = workouts[indexPath.item] as? String ?? ""
        VC.workout = workout
        self.navigationController!.pushViewController(VC, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        print(index)
    }
}
