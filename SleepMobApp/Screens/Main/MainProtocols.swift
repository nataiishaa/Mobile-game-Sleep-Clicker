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
    func display(viewModel: [CharacterViewData], balance: Int)
    func display(boostViewData: [BoostViewData], autoClick: Bool)
}

protocol MainInteractor: AnyObject {
    func set(router: MainRouter)
    func showCharacters()
    func didCharacterTapped(index: Int)
    func startTimer()
    func stopTimer()
}

protocol MainPresenter: AnyObject {
    func show(characters: [CharacterModel], balance: Int)
    func show(boosts: [BoostModel])
}

protocol MainRouter: AnyObject {
    func goToShop()
}
