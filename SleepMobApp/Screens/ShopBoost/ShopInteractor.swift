//
//  ShopInteractor.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 26.03.2024.
//

final class ShopInteractorImp {
    private var presenter: ShopPresenter?
    private var router: ShopRouter?
    private var model: ShopModelDTO
    
    init(presenter: ShopPresenter, model: ShopModelDTO) {
        self.presenter = presenter
        self.model = model
    }
}

// MARK: - MainInteractor

extension ShopInteractorImp: ShopInteractor {
    func set(router: ShopRouter) {
        self.router = router
    }
    
    func activate() {
        presenter?.present(model: model)
    }
    
    func didCharacterTapped(index: Int) {
        //model.items[index].state = model.items[index].state.next
        presenter?.present(model: model)
    }
}
