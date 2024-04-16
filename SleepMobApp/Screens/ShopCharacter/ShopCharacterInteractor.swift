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
    private let cdContext = CoreDataManager.shared.context
    
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
        presenter?.present(model: model, balance: UserData.balance)
    }
    
    func didCharacterTapped(index: Int) {
        let hero = model.items[index].type
        let currentCharacters = FetchRequester.getCharacters(context: cdContext)
        
        guard currentCharacters.count < 8 else {
            router?.showAlert(title: nil, message: "Максимум персонажей")
            return
        }
        
        guard UserData.balance >= hero.price else {
            router?.showAlert(title: nil, message: "Недостаточно денег")
            return
        }
        
        UserData.balance -= hero.price
        let character = CharacterModel(type: hero)
        cdContext.insert(character)
        CoreDataManager.save(context: cdContext)
        presenter?.present(model: model, balance: UserData.balance)
    }
}
