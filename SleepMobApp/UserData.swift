//
//  UserData.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 11.04.2024.
//

import Foundation

struct UserData {
    static var balance: Int {
        get {
            UserDefaults.standard.integer(forKey: "balance")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "balance")
        }
    }
}
