//
//  ShopRouter.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 26.03.2024.
//

import UIKit

final class ShopRouterImp {
    private weak var interactor: ShopInteractor?
    private weak var view: ShopViewControllerProtocol?
    
    init(
        interactor: ShopInteractor,
        view: ShopViewControllerProtocol
    ) {
        self.interactor = interactor
        self.view = view
    }
}

// MARK: - ShopRouter

extension ShopRouterImp: ShopRouter {
    func goToCharacterShop() {
        if let viewController = view as? UIViewController {
            let cshVC = ShopCharacterAssemblyImp().assemble()
            cshVC.modalPresentationStyle = .fullScreen
            viewController.present(cshVC, animated: true)
        }
    }
    
    func goToSettings() {
        if let viewController = view as? UIViewController {
            let setVC = SettingsViewController()
            setVC.modalPresentationStyle = .fullScreen
            viewController.present(setVC, animated: true)
        }
    }
    
  
    
}




// MARK: - MainRouter




