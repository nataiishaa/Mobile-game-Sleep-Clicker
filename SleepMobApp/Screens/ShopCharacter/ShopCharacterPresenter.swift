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
    func present(model: ShopCharacterModelDTO) {
        let heroes: [Character] = model.items.map {
            .init(
                name: $0.type.name,
                imageAwake: UIImage(named: $0.type.imageAwakeName),
                imageSleep: UIImage(named: $0.type.imageAwakeName),
                sleepState: .awake
            )
        }
        let viewModel:ShopCharacterViewModel = .init(heroes: heroes)
        view?.display(viewModel: viewModel)
    }
}

