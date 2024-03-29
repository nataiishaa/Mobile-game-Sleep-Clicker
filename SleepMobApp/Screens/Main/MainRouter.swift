//
//  MainRouter.swift
//  SleepMobApp
//

import UIKit

final class MainRouterImp {
    private weak var interactor: MainInteractor?
    private weak var view: MainViewControllerProtocol?
    
    init(
        interactor: MainInteractor,
        view: MainViewControllerProtocol
    ) {
        self.interactor = interactor
        self.view = view
    }
}

// MARK: - MainRouter

extension MainRouterImp: MainRouter {
    func goToShop() {
        if let viewController = view as? UIViewController {
            let shopVC = ShopAssemblyImp().assemble()
            shopVC.modalPresentationStyle = .fullScreen
            viewController.present(shopVC, animated: true)
        }
    }
    
}
