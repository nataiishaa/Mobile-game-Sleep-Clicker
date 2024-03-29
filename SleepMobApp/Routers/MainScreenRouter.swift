//
//  MainScreenRouter.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 10.03.2024.
//




import UIKit

// Протокол Router
protocol MainScreenRoutingLogic {
    func routeToSettings()
    func presentModalScreen()
}

//// Протокол для передачи данных между экранами,
////protocol MainScreenDataPassing {
////    var dataStore: MainScreenDataStore? { get }
////}
//
//// Класс MainScreenRouter
//final class MainScreenRouter: MainScreenRoutingLogic, MainScreenDataPassing {
//    weak var viewController: MainScreenViewController?
//    var dataStore: MainScreenDataStore?
//    
//    // Функция для перехода к экрану настроек
//    func routeToSettings() {
//        let settingsViewController = SettingsViewController()
//        viewController?.navigationController?.pushViewController(settingsViewController, animated: true)
//    }
//    
//    // Функция для отображения модального экрана
//    func presentModalScreen() {
//        let modalViewController = ModalViewController()
//        // логика передачи данных
//        viewController?.present(modalViewController, animated: true, completion: nil)
//    }
//}
//
//extension MainScreenViewController {
//    func someActionThatRoutesToSettings() {
//        router?.routeToSettings()
//    }
//    
//    func someActionThatPresentsModalScreen() {
//        router?.presentModalScreen()
//    }
//}
