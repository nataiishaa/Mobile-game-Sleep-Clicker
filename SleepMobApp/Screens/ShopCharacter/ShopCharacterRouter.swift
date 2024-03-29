//
//  ShopCharacterRouter.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 29.03.2024.
//

import UIKit

final class ShopCharacterRouterImp {
    private weak var interactor: ShopCharacterInteractor?
    private weak var view: ShopCharacterViewControllerProtocol?
    
    init(
        interactor: ShopCharacterInteractor,
        view: ShopCharacterViewControllerProtocol
    ) {
        self.interactor = interactor
        self.view = view
    }
}

// MARK: - ShopRouter

extension ShopCharacterRouterImp: ShopCharacterRouter {
    func goToMain() {
        if let viewController = view as? UIViewController {
            let mVC = MainAssemblyImp().assemble()
            mVC.modalPresentationStyle = .fullScreen
            viewController.present(mVC, animated: true)
        }
    }
    
    func goToShopBoosts() {
        if let viewController = view as? UIViewController {
            viewController.dismiss(animated: true)
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



