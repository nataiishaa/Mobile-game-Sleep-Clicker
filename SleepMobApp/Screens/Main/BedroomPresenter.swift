//
//  MainPresenter.swift
//  SleepMobApp
//

import UIKit

final class BedroomPresenter: BedroomPresentationLogic {
    weak var view: BedroomDisplayLogic?

    // MARK: - PresentationLogic
    func presentStart(_ response: Model.Start.Response) {
        let characters: [CharacterViewData] = response.characters.map {
            .init( name: $0.characterType.name,
                   hp: $0.hp,
                   sleepiness: $0.sleepiness,
                   lives: $0.lives,
                   image: $0.characterState == .awake ? UIImage(named: $0.characterType.imageAwakeName) : UIImage(named: $0.characterType.imageSleepName))
        }
        
        let boostsViewData: [BoostViewData] = response.boosts.compactMap {
            .init(imageBoost: UIImage(named: $0.boostType.imageBoostName), timer: $0.timer.dateToString(format: "mm:ss"))
        }
        
        let autoClick = response.boosts.contains(where: { $0.boostType == .fairy })
        
        view?.displayStart(
            Model.Start.ViewModel(
                balance: response.balance,
                characters: characters,
                boostViewData: boostsViewData,
                isAutoClick: autoClick
            )
        )
    }
}
