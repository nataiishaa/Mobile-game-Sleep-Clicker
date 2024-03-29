//
//  ShopPresenter.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 26.03.2024.
//


import UIKit

final class ShopPresenterImp {
    private weak var view: ShopViewControllerProtocol?
    
    init(view: ShopViewControllerProtocol) {
        self.view = view
    }
}

// MARK: - MainPresenter

extension ShopPresenterImp: ShopPresenter {
    func present(model: ShopModelDTO) {
        let improves: [Boost] = model.items.map {
            .init(
                name: $0.type.name,
                imageBoost: UIImage(named: $0.type.imageAwakeName)
            )
        }
        let viewModel: ShopViewModel = .init(improves: improves)
        view?.display(viewModel: viewModel)
    }
}
