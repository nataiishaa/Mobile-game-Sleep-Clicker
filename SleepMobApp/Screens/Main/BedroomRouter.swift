//
//  MainRouter.swift
//  SleepMobApp
//

import UIKit


final class BedroomRouter: BedroomRoutingLogic {
    weak var view: UIViewController?

    func routeToShop() {
        let shopVC = ShopAssemblyImp().assemble()
        shopVC.modalPresentationStyle = .fullScreen
        view?.present(shopVC, animated: true)
    }
}
