//
//  MainInteractor.swift
//  SleepMobApp
//

final class MainInteractorImp {
    private var presenter: MainPresenter?
    private var router: MainRouter?
    private var model: MainModelDTO
    
    init(presenter: MainPresenter, model: MainModelDTO) {
        self.presenter = presenter
        self.model = model
    }
}

// MARK: - MainInteractor

extension MainInteractorImp: MainInteractor {
    func set(router: MainRouter) {
        self.router = router
    }
    
    func activate() {
        presenter?.present(model: model)
    }
    
    func didCharacterTapped(index: Int) {
        model.items[index].state = model.items[index].state.next
        presenter?.present(model: model)
    }
}
