//
//  GlobalMethods.swift
//  Retroo
//
//  Created by Ali Sher on 17/11/2021.
//

import UIKit
import Firebase


class GlobalMethods: NSObject {
    
    public static func CreateCardView(radius: CGFloat, view: UIView){
        
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 2;
        view.layer.masksToBounds = false
        view.layer.cornerRadius = radius
        
    }
    
    
    public static func validateEmail(enteredEmail:String) -> Bool {

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
}
