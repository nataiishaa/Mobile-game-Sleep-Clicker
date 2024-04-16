//
//  UserData.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 11.04.2024.
//

import Foundation


let defaults = UserDefaults.standard

struct UserData {
    static var balance: Int {
        get {
            defaults.integer(forKey: "balance")
        }
        set {
            defaults.set(newValue, forKey: "balance")
        }
    }
}
    
