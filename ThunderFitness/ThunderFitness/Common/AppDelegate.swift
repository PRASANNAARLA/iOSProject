//
//  AppDelegate.swift
//  Retroo
//
//  Created by shabnam shaik on 17/11/2021.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.layoutIfNeededOnUpdate = true

        
        UINavigationBar.appearance().barTintColor = Constant.BackgroundColor
        UINavigationBar.appearance().tintColor = Constant.mainTextColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.mainTextColor!]
        UINavigationBar.appearance().isTranslucent = false
        
        FirebaseApp.configure()
          
        let theme = UserDefaults.standard.value(forKey: "theme") as? String ?? "light"
        if theme == "light" {
            
            window?.overrideUserInterfaceStyle = .light
        }else{
            
            window?.overrideUserInterfaceStyle = .dark
        }
        
        
        
        return true
    }
}

