//
//  HomeViewController.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 25/11/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet var dataCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.isHidden = false
        
        dataCollectionView.backgroundColor = .clear
        dataCollectionView.delegate = self
        dataCollectionView.dataSource = self
        dataCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
}


extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 48, left: 24, bottom: 32, right:24)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        var width = 0
        let view = self.view.frame.size.width / 2
        
        width = Int(view)
        width -= 40
        
        return CGSize(width: width, height: width + 24)
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        
        GlobalMethods.CreateCardView(radius: 10, view: cell.contantView)
        
        if indexPath.item == 0 {
            
            cell.imgView.image = UIImage(named: "workout")
            cell.titleLbl.text = "Workout"
            
        }else if indexPath.item == 1 {
            
            cell.imgView.image = UIImage(named: "diet")
            cell.titleLbl.text = "Diet"
            
        }else if indexPath.item == 2 {
            
            cell.imgView.image = UIImage(named: "trainer")
            cell.titleLbl.text = "Trainer"
            
        }else {
            
            cell.imgView.image = UIImage(named: "personalization")
            cell.titleLbl.text = "Personalization"
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            
            let VC = self.storyboard!.instantiateViewController(withIdentifier: "WorkoutViewController") as! WorkoutViewController
            self.navigationController!.pushViewController(VC, animated: true)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }else if indexPath.item == 1 {
            
            let VC = self.storyboard!.instantiateViewController(withIdentifier: "DietaryViewController") as! DietaryViewController
            self.navigationController!.pushViewController(VC, animated: true)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }else if indexPath.item == 2 {
            
            let VC = self.storyboard!.instantiateViewController(withIdentifier: "TrainersViewController") as! TrainersViewController
            self.navigationController!.pushViewController(VC, animated: true)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }else{
            
            let VC = self.storyboard!.instantiateViewController(withIdentifier: "PersonalizationViewController") as! PersonalizationViewController
            self.navigationController!.pushViewController(VC, animated: true)
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        print(index)
    }
}
