//
//  MainProtocols.swift
//  SleepMobApp
//

import UIKit

protocol MainAssembly {
    func assemble() -> UIViewController
}

protocol MainViewControllerProtocol: AnyObject, UICollectionViewDelegate, UICollectionViewDataSource {
    func set(interactor: MainInteractor)
    func display(viewModel: MainViewModel)
}

protocol MainInteractor: AnyObject {
    func set(router: MainRouter)
    func activate()
    func didCharacterTapped(index: Int)
}

protocol MainPresenter: AnyObject {
    func present(model: MainModelDTO)
}

protocol MainRouter: AnyObject {
    func goToShop()
}
