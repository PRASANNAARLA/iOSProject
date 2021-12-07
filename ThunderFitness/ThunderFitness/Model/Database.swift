//
//  Database.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 17/11/2021.
//

import Foundation
import Firebase

class FirebaseTables: NSObject {
    
    static var User: DatabaseReference {
        return Database.database().reference().child("users")
    }
    
    static var Help: DatabaseReference {
        return Database.database().reference().child("help")
    }
    
    static var Trainers: DatabaseReference {
        return Database.database().reference().child("trainers")
    }
    
    static var Workouts: DatabaseReference {
        return Database.database().reference().child("workouts")
    }
    
    static var Dietary: DatabaseReference {
        return Database.database().reference().child("Dietary")
    }
}

