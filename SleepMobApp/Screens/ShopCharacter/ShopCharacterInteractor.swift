//
//  ShopCharacterInteractor.swift
//  SleepMobApp
//
//  Created by Наталья Захарова on 29.03.2024.
//

final class ShopCharacterInteractorImp {
    private var presenter: ShopCharacterPresenterImp?
    private var router: ShopCharacterRouter?
    private var model: ShopCharacterModelDTO
    
    init(presenter: ShopCharacterPresenterImp, model: ShopCharacterModelDTO) {
        self.presenter = presenter
        self.model = model
    }
}

// MARK: - MainInteractor

extension ShopCharacterInteractorImp: ShopCharacterInteractor {
    func set(router: ShopCharacterRouter) {
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
