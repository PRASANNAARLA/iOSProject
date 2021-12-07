//
//  CustomTabBar.swift
//  GoodBoy
//
//  Created by shabnam shaik on 18/10/2021.
//  Copyright © 2021 shabnam shaik. All rights reserved.
//

import Foundation
import UIKit

class customTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.unselectedItemTintColor = Constant.LightColor
        self.tabBar.tintColor = Constant.SelectedColor
        
        if #available(iOS 15.0, *) {
            
            let tabBarAppearance = UITabBarAppearance()
            let tabBarItemAppearance = UITabBarItemAppearance()
            
            tabBarAppearance.backgroundColor = .white
            tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Constant.LightColor]
            
            tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
            self.tabBar.standardAppearance = tabBarAppearance
        }
    }
}
