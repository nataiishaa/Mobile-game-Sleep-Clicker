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
            let presentingViewController = viewController.presentingViewController
            viewController.dismiss(animated: false) {
                presentingViewController?.present(cshVC, animated: false)
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




// MARK: - MainRouter




