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
            viewController.dismiss(animated: true)
        }
    }
    
    func goToShopBoosts() {
        if let viewController = view as? UIViewController {
            let shopVC = ShopAssemblyImp().assemble()
            shopVC.modalPresentationStyle = .fullScreen
            let presentingViewController = viewController.presentingViewController
            viewController.dismiss(animated: false) {
                presentingViewController?.present(shopVC, animated: false)
            }
        }
    }
    
    func goToSettings() {
        if let viewController = view as? UIViewController {
            let setVC = SettingsViewController()
            setVC.modalPresentationStyle = .fullScreen
            viewController.present(setVC, animated: true)
        }
    }

    func showAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default))
        (view as? UIViewController)?.present(alert, animated: true)
    }
}



