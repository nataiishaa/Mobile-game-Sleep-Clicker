//
//  MainPresenter.swift
//  SleepMobApp
//

import UIKit

final class MainPresenterImp {
    private weak var view: MainViewControllerProtocol?
    
    init(view: MainViewControllerProtocol) {
        self.view = view
    }
}

// MARK: - MainPresenter

extension MainPresenterImp: MainPresenter {
    func present(model: MainModelDTO) {
        let characters: [Character] = model.items.map {
            .init(
                name: $0.type.name,
                imageAwake: UIImage(named: $0.type.imageAwakeName),
                imageSleep: UIImage(named: $0.type.imageSleepName),
                sleepState: $0.state
            )
        }
        let viewModel: MainViewModel = .init(characters: characters)
        view?.display(viewModel: viewModel)
    }
}
