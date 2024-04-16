//
//  ShopProtocols.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 26.03.2024.
//

//
//  MainProtocols.swift
//  SleepMobApp
//

import UIKit

protocol ShopAssembly {
    func assemble() -> UIViewController
}

protocol ShopViewControllerProtocol: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource {
    func set(interactor: ShopInteractor)
    func display(viewModel: ShopViewModel, balance: Int)
}

protocol ShopInteractor: AnyObject {
    func set(router: ShopRouter)
    func activate()
    func didCharacterTapped(index: Int)
}

protocol ShopPresenter: AnyObject {
    func present(model: ShopModelDTO, balance: Int)
}

protocol ShopRouter: AnyObject {
    func goToSettings()
    func goToCharacterShop()
    func showAlert(title: String?, message: String?)
}


