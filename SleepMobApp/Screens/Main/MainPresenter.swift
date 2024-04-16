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
    func show(characters: [CharacterModel], balance: Int) {
        let characters: [CharacterViewData] = characters.map {
            .init( name: $0.characterType.name,
                   hp: $0.hp,
                   sleepiness: $0.sleepiness,
                   lives: $0.lives,
                   image: $0.characterState == .awake ? UIImage(named: $0.characterType.imageAwakeName) : UIImage(named: $0.characterType.imageSleepName))
        }
        
        view?.display(viewModel: characters, balance: balance)
    }
    
    func show(boosts: [BoostModel]) {
        let boostsViewData: [BoostViewData] = boosts.compactMap({
            .init(imageBoost: UIImage(named: $0.boostType.imageBoostName), timer: $0.timer.dateToString(format: "mm:ss"))
        })
        let autoClick = boosts.contains(where: { $0.boostType == .fairy })
        view?.display(boostViewData: boostsViewData, autoClick: autoClick)
    }
}
