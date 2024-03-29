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
    func display(viewModel: ShopViewModel)
}

protocol ShopInteractor: AnyObject {
    func set(router: ShopRouter)
    func activate()
    func didCharacterTapped(index: Int)
}

protocol ShopPresenter: AnyObject {
    func present(model: ShopModelDTO)
}

protocol ShopRouter: AnyObject {
    func goToSettings()
    func goToCharacterShop()
}


