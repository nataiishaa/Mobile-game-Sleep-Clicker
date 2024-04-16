//
//  ShopCharacterPresenter.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 29.03.2024.
//

import UIKit

final class ShopCharacterPresenterImp {
    private weak var view: ShopCharacterViewControllerProtocol?
    
    init(view: ShopCharacterViewControllerProtocol) {
        self.view = view
    }
}

// MARK: - MainPresenter

extension ShopCharacterPresenterImp: ShopCharacterPresenter {
    func present(model: ShopCharacterModelDTO, balance: Int) {
        let heroes: [CharacterViewData] = model.items.map {
            .init(
                name: $0.type.name,
                hp: 0,
                sleepiness: 0, 
                lives: 0,
                image: UIImage(named: $0.type.imageBuyName),
                price: $0.type.price
            )
        }
        let viewModel:ShopCharacterViewModel = .init(heroes: heroes)
        view?.display(viewModel: viewModel, balance: balance)
    }
}

