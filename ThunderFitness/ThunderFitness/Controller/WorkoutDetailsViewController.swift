//
//  WorkoutDetailsViewController.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 05/12/2021.
//

import UIKit
import FirebaseStorage


class WorkoutDetailsViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var workout = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorView.startAnimating()
        
        let urlString = workout.value(forKey: "image") as? String ?? ""
        if urlString != "" {
            
            let Ref = Storage.storage().reference(forURL: urlString)

            Ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if error != nil {
                    print("Error: Image could not download!")
                } else {
                    self.imgView.image = UIImage(data: data!)
                }
                self.indicatorView.isHidden = true
            }
        }
        
    }
}
