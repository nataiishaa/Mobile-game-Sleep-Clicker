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
    func present(model: ShopModelDTO, balance: Int) {
        let improves: [Boost] = model.items.map {
            .init(
                name: $0.type.name,
                descriptionBoost: $0.type.descriptionBoost, 
                price: $0.type.price,
                imageBoost: UIImage(named: $0.type.imageBoostName)
            )
        }
        let viewModel: ShopViewModel = .init(improves: improves)
        view?.display(viewModel: viewModel, balance: balance)
    }
}
