//
//  SettingsRouter.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 10.03.2024.
//

import UIKit




// Протокол Router для Settings
protocol SettingsRoutingLogic {
    func dismissSettings()
}


//protocol SettingsDataPassing {
//    var dataStore: SettingsDataStore? { get }
//}
//
//// Класс SettingsRouter
//final class SettingsRouter: SettingsRoutingLogic, SettingsDataPassing {
//    weak var viewController: SettingsViewController?
//    var dataStore: SettingsDataStore?
//    
////    // Метод для закрытия экрана настроек
//    func dismissSettings() {

//        // viewController?.navigationController?.popViewController(animated: true)
//    }
//    

//}


extension SettingsViewController {
    func closeButtonTapped() {
       
    }
}

