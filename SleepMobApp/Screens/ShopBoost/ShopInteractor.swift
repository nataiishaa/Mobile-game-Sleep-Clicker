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
    private let cdContext = CoreDataManager.shared.context
    
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
        presenter?.present(model: model, balance: UserData.balance)
    }
    
    func didCharacterTapped(index: Int) {
        let boost = model.items[index]
        
        guard UserData.balance >= boost.type.price else {
            router?.showAlert(title: nil, message: "Недостаточно денег")
            return
        }
        
        if let currentBoost = FetchRequester.getBoosts(context: cdContext, type: boost.type).first {
            router?.showAlert(title: nil, message: "Данный буст ещё активен")
        } else {
            UserData.balance -= boost.type.price
            let newBoost = BoostModel(type: boost.type)
            cdContext.insert(newBoost)
            CoreDataManager.save(context: cdContext)
            presenter?.present(model: model, balance: UserData.balance)
        }
    }
}
