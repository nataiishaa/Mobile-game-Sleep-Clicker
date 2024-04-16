//
//  ShopCharacterProtocols.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 29.03.2024.
//

import UIKit

protocol ShopCharacterAssembly {
    func assemble() -> UIViewController
}

protocol ShopCharacterViewControllerProtocol: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource {
    func set(interactor: ShopCharacterInteractor)
    func display(viewModel: ShopCharacterViewModel, balance: Int)
}

protocol ShopCharacterInteractor: AnyObject {
    func set(router: ShopCharacterRouter)
    func activate()
    func didCharacterTapped(index: Int)
}

protocol ShopCharacterPresenter: AnyObject {
    func present(model: ShopCharacterModelDTO, balance: Int)
}

protocol ShopCharacterRouter: AnyObject {
    func goToSettings()
    func goToShopBoosts()
    func goToMain()
    func showAlert(title: String?, message: String?)
}
